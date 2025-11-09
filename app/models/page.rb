class Page < ApplicationRecord
    has_one_attached :image
    
    validates :title,
               presence: true,
               format: { with: /\A[a-zA-Z\s'-]+\z/, message: "can only contain letters, spaces, apostrophes, or hyphens" }

    validates :slug,
               presence: true,
               uniqueness: true,
               format: { with: /\A[a-z\s'-]+\z/, message: "can only contain lowercase letters" }

    validates :content,
               presence: true,
               length: { minimum: 10, maximum: 1000 }

    validates :image_alt,
               presence: true,
               format: { with: /\A[a-zA-Z\s'-]+\z/, message: "can only contain letters, spaces, apostrophes, or hyphens" }

    def self.ransackable_attributes(auth_object = nil)
        ["id", "title", "slug", "content", "created_at", "updated_at", "image_alt"]
    end
end
