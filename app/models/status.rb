class Status < ApplicationRecord
    has_many :products

    validates :status_name, presence: true
end
