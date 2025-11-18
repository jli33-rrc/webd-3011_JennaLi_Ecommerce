class PurchaseProduct < ApplicationRecord
  belongs_to :purchase
  belongs_to :product

  validates :price, numericality: { greater_than_or_equal_to: 0 }

  validates :quantity, numericality: { greater_than: 0 }

  validates :purchase_id,
             presence: true,
             numericality: { only_integer: true, greater_than: 0 }

  validates :product_id,
             presence: true,
             numericality: { only_integer: true, greater_than: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "price", "quantity", "purchase_id", "product_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["purchase", "product"]
  end
end
