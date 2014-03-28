require_relative '../../config/application'
require_relative '../models/movie'
require_relative '../models/user'
require_relative '../views/cool'
# require 'debugger'

class Controller

  def self.run
    # debugger
    View.welcome

    answer = View.options
    until answer == 'login' or answer == 'register' do answer = View.options; end
    option_choice(answer)
    View.goodbye
  end

  def self.option_choice(answer)
    case answer
    when "login"
      login_data = View.login
      User.login(login_data)
    when "register"
      new_user_data = View.register
      User.create(new_user_data)
     "Please enter 'login' or 'register'. Don't fail."
    end
  end
end

Controller.run