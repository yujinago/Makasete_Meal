class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :recipes, dependent: :destroy
  has_many :restaurants, dependent: :destroy
  
  validates :nickname, presence: true, length: { maximum: 10 }
  validates :email, presence: true, uniqueness: true
  
  GUEST_USER_EMAIL = "guest_#{SecureRandom.hex(3)}@example.com"
  
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "guestuser"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
end
