class Restaurant < ApplicationRecord
  has_one_attached :restaurant_image
  belongs_to :user
  belongs_to :restaurant_genre
end
