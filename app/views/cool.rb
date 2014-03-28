# require_relative '../../config/application'
# require_relative '../models/movie'
# require_relative '../models/user'
require 'colorize'

class View
  WELCOME = :cyan
  INPUT   = :yellow
  ALERT   = :red
  LIST    = :magenta

  def self.welcome
    puts ""
    puts "Welcome to Paolo's kind of really cool idea!!!".center(60).colorize(WELCOME)
  end

  def self.options
    puts ""
    puts "Have you ever been here before? Would you like to 'register' or 'login'?".colorize(INPUT)
    answer = gets.chomp!

  end

  def self.register
    puts "What is your name?".colorize(INPUT)
    name = gets.chomp!
    puts "Pick a username".colorize(INPUT)
    username = gets.chomp!
    puts "Choose a password".colorize(INPUT)
    password = gets.chomp!
    puts "Email address?".colorize(INPUT)
    email = gets.chomp!
    puts "You are now trapped in Paolo's kind of cool idea.".colorize(ALERT)
    new_user_data = {name: name, email: email, username: username, password: password}
  end

  def self.login
    puts ""
    puts "Please enter your username".colorize(INPUT)
    username = gets.chomp!
    puts ""
    puts "Please enter your password".colorize(INPUT)
    password = gets.chomp!
    login_data = {username: username, password: password}
  end

  def self.incorrect_password
    puts ""
    puts "Your username/password information was incorrect, please try again!".colorize(ALERT)
    login
  end
  def self.successful_login
    puts ""
    puts "You have successfuly logged in!".colorize(ALERT)

  end

  def self.logged_in_options
    puts ""
    puts "Type 'list' to view all of the movies you have watched.\nType 'add' to add a movie to your list that you have recently watched.\nType 'delete' to remove a movie from your list.\nType 'logout' to log out and exit this program."
    puts
    answer = gets.chomp!
    logged_in_options unless answer == 'list' or answer == 'add' or answer == 'logout' or answer == 'delete'
    return answer
  end

  def self.add_movie_to_user_list
    puts ""
    puts "type in the movie title".colorize(INPUT)
    movie = gets.chomp!
  end

  def self.delete_movie_from_user_list
    puts ""
    puts "type in the id of the movie you want to delete".colorize(INPUT)
    answer = gets.chomp!
  end

  def self.list_potential_movies_to_add(potential_movies)
    puts ""
    potential_movies.each_with_index do |movie, index|
      puts "#{index + 1}. #{movie.title} (#{movie.year})"
    end
    puts ""
    puts "Select a movie from the list above to add. Choose the id to the left of the movie title.".colorize(INPUT)

    answer = gets.chomp!
  end

  def self.display_user_movies(movies)
    puts ""
    movies.each_with_index do |movie, index|
      puts "#{index + 1}. #{movie.title} (#{movie.year})".colorize(LIST)
    end

  end

  def self.movie_added(user)
    puts ""
    puts "#{user.movies[-1].title} has been added to your list!".colorize(ALERT)

  end

  def self.no_movies
    puts ""
    puts "You do not have any movies yet.".colorize(ALERT)
  end

  def self.goodbye
    puts ""
    puts "goodbye"

  end

  private

  def clear
    print "\e[2J"
    print "\e[H"
  end

end

