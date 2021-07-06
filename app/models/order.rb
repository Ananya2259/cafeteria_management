class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  def self.order_display(user_id)
    user = User.find(user_id)
    if user.role == "Admin" || user.role == "clerk"
      Order.all
    else
      user.orders
    end
  end
end
