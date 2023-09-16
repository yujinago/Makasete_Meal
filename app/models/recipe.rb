class Recipe < ApplicationRecord
  has_one_attached :recipe_image
  belongs_to :user
  belongs_to :recipe_category
  
  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1},
    presence: true, on: :update
    
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}
  
  # foodstuff_nameの表記が見やすくなるよう変更
  def foodstuff_name_format
    cleaned_string = foodstuff_name.gsub(/\[|\]|"/, '')
    foodstuff_name_array = cleaned_string.split(', ')
    foodstuff_name_array.join(', ')
  end
  
  def get_recipe_image(width, height)
    unless recipe_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      recipe_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
    recipe_image.variant(resize_to_limit: [width, height]).processed
  end
end
