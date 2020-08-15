class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :balance, :numericality => { :greater_than_or_equal_to => 0 }

  def subscribe? combo
    Subscription.find_by(combo: combo, user: self)
  end
end
