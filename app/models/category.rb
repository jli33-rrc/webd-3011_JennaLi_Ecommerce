class Category < ApplicationRecord
    has_many :products, dependent: :destroy

    validates :category_name, presence: true
end
