class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.find_by(username: slug.gsub("-", " "))
  end
end
