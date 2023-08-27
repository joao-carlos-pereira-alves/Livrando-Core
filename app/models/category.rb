class Category < ApplicationRecord
  has_many :book_categories

  validates :name, presence: true
end