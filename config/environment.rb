require 'bundler/setup'
Bundler.require

DB = {:conn => SQLite3::Database.new("movieapp.db")}
DB[:conn].execute("DROP TABLE IF EXISTS movies;")
DB[:conn].execute("DROP TABLE IF EXISTS users;")
DB[:conn].execute("DROP TABLE IF EXISTS connections;")

create_movies = <<-SQL 
CREATE TABLE movies(
  id INTEGER PRIMARY KEY,
  title TEXT,
  genre TEXT);
SQL
#to possible add to movie model later if 
# we implement the API
  # year INTEGER,
  # released TEXT,
  # rating TEXT,
  # runtime TEXT,
  # direction TEXT,
  # actors TEXT,
  # writers TEXT,
  # plot TEXT,
  # language TEXT,
  # country TEXT,
  # awards TEXT,
  # poster TEXT,
  # metascore INTEGER,
  # imdb_rating INTEGER,
  # imdb_votes INTEGER,
  # imdb_id TEXT,
  # type TEXT

create_users = <<-SQL 
CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  name TEXT,
  favorite_movie_id INTEGER);
SQL

create_connections = <<-SQL 
CREATE TABLE connections(
  id INTEGER PRIMARY KEY,
  movie_id INTEGER,
  user_id INTEGER);
SQL

DB[:conn].execute(create_movies)
DB[:conn].execute(create_users)
DB[:conn].execute(create_connections)
DB[:conn].results_as_hash = true

def exec(query)
  DB[:conn].execute(query)
end

require_all 'app'