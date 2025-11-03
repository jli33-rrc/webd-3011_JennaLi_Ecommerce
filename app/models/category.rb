class Category < ApplicationRecord
    has_many :products, dependent: :destroy

    validates :category_name, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["id", "category_name", "created_at", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["products"]
    end
end
