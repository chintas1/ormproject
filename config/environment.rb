require 'bundler/setup'
Bundler.require

DB = {:conn => SQLite3::Database.new("movieapp.db")}

DB[:conn].results_as_hash = true

def exec(query)
  DB[:conn].execute(query)
end

require_all 'app'