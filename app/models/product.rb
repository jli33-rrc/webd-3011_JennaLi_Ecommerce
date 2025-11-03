class Product < ApplicationRecord
  belongs_to :category
  belongs_to :status

  has_one_attached :image

  validates :product_name,
             presence: true,
             uniqueness: true,
             length: { minimum: 2, maximum: 100 },
             format: { with: /\A[a-zA-Z\s'-]+\z/, message: "can only contain letters, spaces, apostrophes, or hyphens" }

  validates :price,
             presence: true,
             numericality: { greater_than: 0 }

  validates :description,
             presence: true,
             length: { minimum: 10, maximum: 1000 }

  validates :category_id,
             presence: true,
             numericality: { only_integer: true, greater_than: 0 }

  validates :status_id,
             presence: true,
             numericality: { only_integer: true, greater_than: 0 }

  # validates :image, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "product_name", "price", "description", "category_id", "status_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "status"]
  end
end
