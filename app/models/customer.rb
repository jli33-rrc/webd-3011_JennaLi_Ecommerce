class Customer < ApplicationRecord
  belongs_to :province

  has_many :purchases, dependent: :destroy

  validates :first_name,
             presence: true,
             format: { with: /\A[a-zA-Z\s'-]+\z/, message: "can only contain letters, spaces, apostrophes, or hyphens" }

  validates :last_name,
             presence: true,
             format: { with: /\A[a-zA-Z\s'-]+\z/, message: "can only contain letters, spaces, apostrophes, or hyphens" }

  validates :email,
             presence: true,
             format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :address,
             format: { with: /\A[a-zA-Z0-9\s#.,'-]+\z/, message: "can only contain letters, numbers, spaces, commas, periods, hyphens, apostrophes, or #" }
  
  validates :city,
             format: { with: /\A[a-zA-Z\s'-]+\z/, message: "can only contain letters, spaces, apostrophes, or hyphens" }

  validates :postal_code,
             format: { with: /\A[ABCEGHJ-NPRSTVXY]\d[ABCEGHJ-NPRSTV-Z]\s?\d[ABCEGHJ-NPRSTV-Z]\d\z/i, message: "must be a valid Canadian postal code (e.g., A1A 1A1)" }
  
  validates :province_id,
             presence: true,
             numericality: { only_integer: true, greater_than: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "first_name", "last_name", "email", "address", "city", "postal_code", "province_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["province"]
  end

  def to_s
    id
  end
end
