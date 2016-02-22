require_all 'app'
require 'sqlite3'

DB = {:conn => SQLite3::Database.new("db/movieapp.db")}

DB[:conn].results_as_hash = true