require_relative '../../config/application'
require_relative '../models/movie'
require_relative '../models/user'


class View
  def self.welcome
    puts "Welcome to Paolo's kind of cool idea"
  end
  def options

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
    User.create(name: name, email: email, username: username, password: password)
  end

end

View.welcome
View.register