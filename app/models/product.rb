class Product < ApplicationRecord
  belongs_to :category
  belongs_to :status

  has_one_attached :image

  validates :product_name, :price, presence: true
end
