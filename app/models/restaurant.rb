class Restaurant < ApplicationRecord
  attr_accessor :restaurant_middle_area
  has_one_attached :restaurant_image
  belongs_to :user
  belongs_to :restaurant_genre
  has_one :restaurant_favorite, dependent: :destroy
  
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
  
  def favorited_by?(user)
    !restaurant_favorite.nil? && restaurant_favorite.user_id == user.id
  end
  
  def self.looks(search, word, user_id)
    if search == "name"
      Restaurant.where("name LIKE? AND user_id = ?", "%#{word}%", user_id)
    elsif search == "address"
      Restaurant.where("address LIKE? AND user_id = ?", "%#{word}%", user_id)
    elsif search == "open_time"
      Restaurant.where("open_time LIKE? AND user_id = ?", "%#{word}%", user_id)
    elsif search == "legular_holiday"
      Restaurant.where("legular_holiday LIKE? AND user_id = ?", "%#{word}%", user_id)
    end
  end

end