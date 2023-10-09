class Contact include ActiveModel::Model
  attr_accessor :nickname, :email, :content
   
  validates :nickname, presence: true
  validates :email, presence: true
  validates :content, presence: true
end