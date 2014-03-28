require_relative '../../config/application'
require_relative '../models/movie'
require_relative '../models/user'
require_relative '../views/cool'
require 'debugger'

class Controller

  def self.run
    # debugger
    View.welcome

    answer = View.options
    until answer == 'login' or answer == 'register' do answer = View.options; end
    option_choice(answer)
    View.goodbye
  end

  def self.option_choice(answer="login")
    case answer
    when "login"
      # debugger
      login_data = View.login
      p login_data
      User.login(login_data)
    when "register"
      new_user_data = View.register
      User.create(new_user_data)
     "Please enter 'login' or 'register'. Don't fail."
    end
  end

  def self.incorrect_password
    login_data = View.incorrect_password
    User.login(login_data)
    successfully_logged_in
  end

  def self.successfully_logged_in(user)
    View.successful_login
    logged_in_user_commands(user)
  end

  def self.logged_in_user_commands(user)
    puts "Type 'list' to view all of the moviesyou have watched. Type 'add' to add a movie to your list that you have recently watched."
    answer = gets.chomp!
    if answer == 'list'
      user.movies
    elsif answer == 'add'
      puts "type in the movie title"
      movie = gets.chomp!
      # Get from model/database
      # user.movies << movie
    end

  end
end

Controller.run