require_relative '../../config/application'
require_relative '../models/movie'
require_relative '../models/user'


class View
  def self.welcome
    puts "Welcome to Paolo's kind of cool idea!!!"
  end

  def self.options
    puts "Have you ever been here before? Would you like to register or login?"
    answer = gets.chomp!

  end

  def self.register
    puts "What is your name?"
    name = gets.chomp!
    puts "Pick a username"
    username = gets.chomp!
    puts "Choose a password"
    password = gets.chomp!
    puts "Email address?"
    email = gets.chomp!
    puts "You are now trapped in Paolo's kind of cool idea."
    new_user_data = {name: name, email: email, username: username, password: password}
  end

  def self.login
    puts "Please enter your username"
    username = gets.chomp!
    puts "Please enter your password"
    password = gets.chomp!
    login_data = {username: username, password: password}
  end

  def self.incorrect_password
    puts "Your username/password information was incorrect, please try again!"
    login
  end
  def self.successful_login
    puts "You have successfuly logged in!"
  end

  def self.goodbye
    puts "goodbye"
  end


end

