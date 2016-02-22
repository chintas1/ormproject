require "net/http"
require "uri"
class Movie
  extend Databaseable::ClassMethods
  include Databaseable::InstanceMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    title: "TEXT",
    genre_id: "INTEGER"
  }
  attr_accessor(*self.public_attributes)  
  attr_reader :id


  def self.add_or_find_movie_by_name(movie_name)
    movie = find_movie_by_name(movie_name)
    if movie.nil?
      movie_data = find_movie_data_by_name(movie_name)
      if movie_data.fetch(:Response) == "False"
        puts "That movie could not be found." 
        return
      end
      movie = Movie.new(movie_data)
      movie.save
    else
      movie
    end
  end

  def self.find_movie_data_by_name(movie_name)
    formatted_name = movie_name.gsub(" ", "+")
    response = Net::HTTP.get_response("omdbapi.com","/?t=#{formatted_name}&format=json")
    movie_info = eval(response.body)
    movie_info
  end

  def self.find_movie_by_name(movie_name)
    movie_info = self.find_by_name(name: movie_name)
    movie_info.empty? ? nil : self.new(movie_info)
  end
end