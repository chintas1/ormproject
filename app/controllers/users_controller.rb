class UserController
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
    movie_name = view.render
    # binding.pry
    movie = Movie.find_by_name(movie_name)

    if movie.empty?
      movie = Movie.new({name: movie_name})
      movie.save
    else
      movie
    end
    join_table = MoviesUsers.new({movie_id: movie.id, user_id: user.id})
    view = MovieAddedView.new
    view.render(movie)
  end

  # add favorite movie
  def set_fav_movie(user)
    view = UserSetFavMovieView.new
    movie_name = view.render
    movie = Movie.find_by_name(movie_name)

    if movie.empty?
      movie = Movie.new({name: movie_name})
      movie.save
      user.fav_movie_id = movie.id
    else
      user.fav_movie_id = movie.id
    end

    join_table = MoviesUsers.new({movie_id: movie.id, user_id: user.id})
    view = MovieAddedView.new
    view.render(movie)
  end

  # get favorite movie

  # get favorite genre
end