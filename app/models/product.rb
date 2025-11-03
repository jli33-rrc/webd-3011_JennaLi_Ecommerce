class Product < ApplicationRecord
  belongs_to :category
  belongs_to :status

  has_one_attached :image

  validates :product_name, :price, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "product_name", "price", "description", "category_id", "status_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "status"]
  end
end
