class RecipeCategory < ApplicationRecord
  has_many :recipes, dependent: :destroy
end
