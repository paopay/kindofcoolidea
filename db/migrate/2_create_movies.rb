require_relative '../../config/application.rb'

class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :year
    end
  end
end