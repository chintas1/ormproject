class MoviesController

  def titlecase(words)
    words.split(" ").map{|word| word.capitalize}.join(" ")
  end

  # add movie to collection
  def add_movie(user)
    view = UserPromptMovieNameView.new
    movie_name = titlecase(view.render)
    # binding.pry
    movie_data = self.find_movie_data_by_name(movie_name)
    if movie_data.fetch(:Response) == "False"
      puts "Invalid Movie"
      return
    else
      movie = Movie.find_or_create_by_name(movie_name)
      first_genre = movie_data.fetch(:Genre).split(", ").first
      genre = Genre.find_or_create_by_name(first_genre)
      genre.save
      movie.genre_id = genre.id
      movie.save
    end

    join_table = MoviesUsers.new({movie_id: movie.id, user_id: user.id})
    join_table.save
    view = MovieAddedView.new
    view.render(movie)
  end

  def lookup_movie
    view = UserPromptMovieNameView.new
    movie_name = titlecase(view.render)
    view = UserDisplayCollectionView.new
    movie_data = find_movie_data_by_name(movie_name)
    view.render(movie_name, movie_data)
  end

  def remove_movie(user)
    view = UserPromptMovieNameView.new
    movie_name = titlecase(view.render)
    movie = Movie.find_by_name(movie_name)
    sql = <<-SQL
      SELECT moviesuserss.* FROM moviesuserss
      INNER JOIN movies ON moviesuserss.movie_id = movies.id
      WHERE moviesuserss.user_id = ? AND moviesuserss.movie_id = ?
    SQL
    
    movie.nil? ? return : join_table_row = DB[:conn].execute(sql, user.id, movie.id).flatten
    join_table_row.empty? ? return : movie_object = MoviesUsers.object_from_row(join_table_row) 
    # binding.pry
    movie_object.destroy
  end

  def find_movie_data_by_name(movie_name)
    formatted_name = movie_name.gsub(" ", "+")
    response = Net::HTTP.get_response("omdbapi.com","/?t=#{formatted_name}&format=json")
    movie_info = eval(response.body)
    movie_info
  end

    # display collection
  def display_collection(user)
    view = UserDisplayCollectionView.new
    movie_names = user.movies.map{|movie| movie.name}
    movie_names.each do |movie|
      movie_data = find_movie_data_by_name(movie)
      view.render(movie, movie_data)
    end
  end

  # add favorite movie
  def set_fav_movie(user)
    view = UserSetFavMovieView.new
    movie_name = titlecase(view.render)

    movie_data = self.find_movie_data_by_name(movie_name)
    if movie_data.fetch(:Response) == "False"
      puts "Invalid Movie"
      return
    else
      movie = Movie.find_or_create_by_name(movie_name)
      user.fav_movie_id = movie.id
      first_genre = movie_data.fetch(:Genre).split(", ").first
      genre = Genre.find_or_create_by_name(first_genre)
      movie.genre_id = genre.id
      movie.save

      join_table = MoviesUsers.new({movie_id: movie.id, user_id: user.id})
      join_table.save
      view = MovieAddedView.new
      view.render(movie)
    end
  end
end