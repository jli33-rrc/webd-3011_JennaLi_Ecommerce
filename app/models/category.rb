class Category < ApplicationRecord
    has_many :products, dependent: :destroy

    validates :category_name,
               presence: true,
               uniqueness: true,
               length: { minimum: 2, maximum: 50 },
               format: { with: /\A[a-zA-Z\s'-]+\z/, message: "can only contain letters, spaces, apostrophes, or hyphens" }

    def self.ransackable_attributes(auth_object = nil)
        ["id", "category_name", "created_at", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["products"]
    end

    def to_s
        category_name
    end
end
