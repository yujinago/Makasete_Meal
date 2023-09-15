class Restaurant < ApplicationRecord
  attr_accessor :restaurant_middle_area
  has_one_attached :restaurant_image
  belongs_to :user
  belongs_to :restaurant_genre
  
  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1},
    presence: true, on: :update
    
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}
  
  def get_restaurant_image(width, height)
    unless restaurant_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      restaurant_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
    restaurant_image.variant(resize_to_limit: [width, height]).processed
  end

end