class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :combo

  has_many :orders

  validates :user_id, :uniqueness => { :scope => :combo_id }

  after_save :check_order_createable

  def check_order_createable
    time = Time.now
    order_group = combo.order_groups.find_by(end_at: nil)
    if time < combo.current_cut_off_time
      #GenerateOrderJob.perform_later(self, order_group.id)
      GenerateOrderJob.perform_now(self, order_group.id)
    end
  end

  def generate_order order_group_id
    # 用户锁，防止用户balance的validates被绕过
    user.with_lock do
      user.update!(balance: user.balance - combo.price)
      Order.create!(subscription_id: id, user: user, combo: combo, order_group_id: order_group_id)
    end
  end
end
