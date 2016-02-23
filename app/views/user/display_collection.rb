class UserDisplayCollectionView
  def render(movie_name, movie_data)
    puts "\nInfo about #{movie_name}:"
    movie_data.each{|key, value| puts "#{key.upcase}: #{value}"}
    puts "------------------------------"
  end
end