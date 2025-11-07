class Page < ApplicationRecord
    validates :title,
               presence: true,
               format: { with: /\A[a-zA-Z\s'-]+\z/, message: "can only contain letters, spaces, apostrophes, or hyphens" }

    validates :slug,
               presence: true,
               uniqueness: true

    validates :content,
               presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["id", "title", "slug", "content", "created_at", "updated_at"]
    end
end
