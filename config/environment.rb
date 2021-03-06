require 'bundler/setup'

Bundler.require

DB = {:conn => SQLite3::Database.new("db/movieapp.db")}

def exec(query)
  DB[:conn].execute(query)
end

def drop_tables
  DB[:conn].execute("DROP TABLE IF EXISTS users")
  DB[:conn].execute("DROP TABLE IF EXISTS moviesuserss")
  DB[:conn].execute("DROP TABLE IF EXISTS movies")
  DB[:conn].execute("DROP TABLE IF EXISTS genres")
end

require_all 'app'

User.create_table
Movie.create_table
MoviesUsers.create_table
Genre.create_table