class MenuCategory < ApplicationRecord
  has_many :menu_items
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2 }
  validates :name, presence: true
end
