class UserController

def titlecase(words)
  words.split(" ").map{|word| word.capitalize}.join(" ")
end

  # add user
  def new_user
    view = UserCreateView.new
    user_name = view.render
    current_user = User.new({name: user_name})
    current_user.save
    view = UserWelcomeView.new
    view.render(current_user)
    current_user
  end

  # add movie to collection
  def add_movie(user)
    view = UserAddMovieView.new
    movie_name = titlecase(view.render)
    # binding.pry
    movie = Movie.find_or_create_by_name(movie_name)
    join_table = MoviesUsers.new({movie_id: movie.id, user_id: user.id})
    join_table.save
    view = MovieAddedView.new
    view.render(movie)
  end

  # add favorite movie
  def set_fav_movie(user)
    view = UserSetFavMovieView.new
    movie_name = titlecase(view.render)
    movie = Movie.find_or_create_by_name(movie_name)
    user.fav_movie_id = movie.id
    join_table = MoviesUsers.new({movie_id: movie.id, user_id: user.id})
    join_table.save
    view = MovieAddedView.new
    view.render(movie)
  end

  # get favorite movie
  def find_fav_movie(user)
    movie = Movie.find(user.fav_movie_id)
    view = DisplayFavMovieView.new
    view.render(movie)
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
    movie_names = user.movies.map{|movie_row| movie_row[1]}
    movie_names.each do |movie|
      movie_data = find_movie_data_by_name(movie)
      view.render(movie, movie_data)
    end
  end

  def lookup_movie
    view = UserAddMovieView.new
    movie_name = titlecase(view.render)
    view = UserDisplayCollectionView.new
    movie_data = find_movie_data_by_name(movie_name)
    view.render(movie_name, movie_data)
  end

  # get favorite genre
end





