# require_relative '../controllers/controller'

class User < ActiveRecord::Base
  has_many :movies, through: :watched_movies
  has_many :watched_movies

  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  def self.login(login_data)
    user = User.find_by_username(login_data[:username])
    if user
      if user.password == login_data[:password]
        Controller.successfully_logged_in(user)
      else
        Controller.incorrect_password
      end
    else
      puts "username not recognized"
    end
  end

end