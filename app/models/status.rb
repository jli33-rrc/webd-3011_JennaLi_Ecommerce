class Status < ApplicationRecord
    has_many :products

    validates :status_name, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["id", "status_name", "created_at", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["products"]
    end
end
