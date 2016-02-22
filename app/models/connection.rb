class MoviesUsers
  extend Databaseable::ClassMethods
  include Databaseable::InstanceMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    movie_id: "INTEGER",
    user_id: "INTEGER",
  }
end