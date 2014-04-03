class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy #this is the relation
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 } #validates name
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i #vemail regex
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, #validates email
    uniqueness: { case_sensitive: false }

  has_secure_password #makes sure the password is encrypted
  validates :password, length: { minimum: 6 } #makes sure password is at least 6 characters

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end 

  def feed
    Micropost.where("user_id = ?", id)
  end

  private
  	def create_remember_token
    	self.remember_token = User.encrypt(User.new_remember_token)
  	end 
end
