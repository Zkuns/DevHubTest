class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order_group
  belongs_to :combo
  belongs_to :subscription

  validates :subscription, :uniqueness => { :scope => :combo_id }
end
