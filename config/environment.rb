require 'bundler/setup'

Bundler.require

DB = {:conn => SQLite3::Database.new("movieapp.db")}

def exec(query)
  DB[:conn].execute(query)
end

def drop_tables
  DB[:conn].execute("DROP TABLE users")
  DB[:conn].execute("DROP TABLE moviesusers")
  DB[:conn].execute("DROP TABLE movies")
  DB[:conn].execute("DROP TABLE genres")
end

require_all 'app'

User.create_table
Movie.create_table
MoviesUsers.create_table
Genre.create_table