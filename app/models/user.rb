class User < ActiveRecord::Base
  has_many :movies, through: :watched_movies
  has_many :watched_movies

  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

end