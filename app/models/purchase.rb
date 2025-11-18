class Purchase < ApplicationRecord
  belongs_to :customer

  has_many :purchase_products, dependent: :destroy
  has_many :products, through: :purchase_products

  accepts_nested_attributes_for :purchase_products, allow_destroy: true

  validates :subtotal, :gst, :pst, :hst, :total, numericality: { greater_than_or_equal_to: 0 }

  validates :customer_id,
             presence: true,
             numericality: { only_integer: true, greater_than: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "subtotal", "gst", "pst", "hst", "total", "customer_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer"]
  end

  def to_s
    id
  end
end
