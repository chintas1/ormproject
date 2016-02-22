class Genre
  extend Databaseable::ClassMethods
  include Databaseable::InstanceMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT"
  }
  attr_accessor(*self.public_attributes)  
  attr_reader :id

end