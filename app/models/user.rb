class User < ActiveRecord::Base
  validates :email, presence: true
  validates :name, presence: true
  validates :email, { presence: true, uniqueness: true }
  has_secure_password
  has_many :cart_items
  has_many :addresses

  def to_user_details
    " Email:#{email} Password:#{password}"
  end
end
