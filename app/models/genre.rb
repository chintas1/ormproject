class Genre
  extend Databaseable::ClassMethods
  include Databaseable::InstanceMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT");
  }
end