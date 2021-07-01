class User < ActiveRecord::Base
  validates :email, presence: true
  validates :name, presence: true
  validates :email, { presence: true, uniqueness: true }
  has_secure_password

  def to_user_details
    " Email:#{email} Password:#{password}"
  end
end
