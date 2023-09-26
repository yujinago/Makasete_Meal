class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :recipes, dependent: :destroy
  has_many :restaurants, dependent: :destroy
  has_many :recipe_favorites, dependent: :destroy
  has_many :restaurant_favorites, dependent: :destroy
  
  validates :nickname, presence: true, length: { maximum: 10 }
  validates :email, presence: true, uniqueness: true
  
  # ゲストログインの際、毎回メールアドレス変更（複数人で使える）
  GUEST_USER_PREFIX = "guest_"
  
  def self.guest
    guest_email = "#{GUEST_USER_PREFIX}#{SecureRandom.hex(3)}@example.com"
    find_or_create_by!(email: guest_email) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "guestuser"
    end
  end
    
  def guest_user?
    email.start_with?(GUEST_USER_PREFIX)
  end
  
end
