class User
  extend Databaseable::ClassMethods
  include Databaseable::InstanceMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    fav_movie_id: "INTEGER");
  }
end