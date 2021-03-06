class UserController

def titlecase(words)
  words.split(" ").map{|word| word.capitalize}.join(" ")
end

  # add user
  def new_user
    view = UserCreateView.new
    user_name = view.render
    current_user = User.find_or_create_by_name(user_name)
    view = UserWelcomeView.new
    view.render(current_user)
    current_user
  end

  # get favorite movie
  def find_fav_movie(user)
    movie = Movie.find(user.fav_movie_id)
    unless (movie.nil?)
      view = DisplayFavMovieView.new
      view.render(movie)
    else
      puts "You don't have a favorite movie."
    end
  end

  # get favorite genre
  def get_fav_genre(user)
    genre_count = user.movies.each_with_object(Hash.new(0)) {|movie, genre_count| genre_count[movie.genre_id] += 1}
    fav_genre_id = genre_count.sort_by {|genre_id, value| value}.last.first
    puts Genre.find(fav_genre_id).name
  end

  def compare(user)
    view = UserPromptView.new
    other_user = User.find_by_name(view.render)
    if other_user.nil?
      puts "Invalid User"
      return nil
    end
    self_movies = User.find(user.id).movies.map {|movie| movie.name}
    other_movies = User.find(other_user.id).movies.map {|movie| movie.name}
    view = DisplayCompareView.new
    view.render(self_movies, other_movies, other_user.name)
  end
end





