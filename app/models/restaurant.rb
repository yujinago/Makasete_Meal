class Restaurant < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant_gen
end
