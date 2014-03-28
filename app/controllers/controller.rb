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
    answer = View.logged_in_options
    if answer == 'list'
      movies = user.movies
      View.display_user_movies(movies)
    elsif answer == 'add'
      movie = View.add_movie_to_user_list
      movie = '%' + movie + '%'
      potential_movies = Movie.where("title LIKE ?", movie)
      movie_to_add = View.list_potential_movies_to_add(potential_movies)

      potential_movies.each_with_index do |movie, index|
        user.movies << movie if index == (movie_to_add.to_i - 1)
      end

      View.movie_added(user)

    else
      exit
    end
    logged_in_user_commands(user)

  end
end

Controller.run