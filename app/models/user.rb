class User < ActiveRecord::Base
  validates :email, presence: true
  validates :name, presence: true
  validates :email, { presence: true, uniqueness: true }
  has_secure_password
  has_many :cart_items
  has_many :addresses
  has_many :orders

  def to_user_details
    " Email:#{email} Password:#{password}"
  end

  def self.define_role(user_id)
    if User.find(user_id).role == "Admin" || User.find(user_id).role == "clerk"
      true
    else
      false
    end
  end
end
