class User
  extend Databaseable::ClassMethods
  include Databaseable::InstanceMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    fav_movie_id: "INTEGER"
  }
  attr_accessor(*self.public_attributes)  
  attr_reader :id

  def movies
    sql = <<-SQL
      SELECT movies.* FROM moviesuserss
      INNER JOIN movies ON moviesuserss.movie_id = movies.id
      WHERE moviesuserss.user_id = ?
    SQL

    movies = DB[:conn].execute(sql, self.id)
    # binding.pry
    movies.uniq
  end

end