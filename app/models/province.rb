class Province < ApplicationRecord
    has_many :customers

    validates :province_name,
               presence: true,
               uniqueness: true,
               format: { with: /\A[a-zA-Z\s'-]+\z/, message: "can only contain letters, spaces, apostrophes, or hyphens" }

    validates :gst, :pst, :hst, numericality: { greater_than_or_equal_to: 0 }

    def self.ransackable_attributes(auth_object = nil)
        ["id", "province_name", "gst", "pst", "hst", "created_at", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["customers"]
    end

    def to_s
        product_name
    end
end
