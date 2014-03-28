require_relative '../../config/application.rb'

class WatchedMovies < ActiveRecord::Migration
  def change
    create_table :watched_movies do |t|
      t.belongs_to :user
      t.belongs_to :movie
      t.timestamps
    end
  end
end