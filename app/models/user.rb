class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :in_reply_to, through: :microposts, source: :user_id
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }
  before_create :create_remember_token
  validates :name, :presence => true, :length => { :maximum => 50 }
  VALID_USERNAME_REGEX = /\A([a-zA-Z0-9][a-zA-Z0-9_-]*)\z/i
  validates :username, :presence => true, :length => { :maximum => 16 }, :format => { :with => VALID_USERNAME_REGEX }, :uniqueness => { :case_sensitive => false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, :presence => true, :format => { :with => VALID_EMAIL_REGEX }, :uniqueness => { :case_sensitive => false }
  has_secure_password
  validates :password, :length => { :minimum => 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.search(search)
    if search.empty?
      return []
    else
      ## This apperently only works on PGSQL
      ##find(:all, :conditions => ['username ILIKE ?', "%#{search}%"])
      find(:all, :conditions => ['lower(username) LIKE lower(?)', "%#{search}%"])
    end
  end

  private 
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
