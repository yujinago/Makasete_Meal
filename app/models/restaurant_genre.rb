class RestaurantGenre < ApplicationRecord
  has_many :restaurants, dependent: :destroy
end
