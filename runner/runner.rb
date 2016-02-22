require_relative '../config/environment.rb'
puts "Welcome to your movie collection manager."
puts "Please enter a username to create your profile."

controller = UserController.new
user = controller.new_user

action=""
while action != "exit"
  puts "Do you want to work on your profile or collection?"
  action=gets.chomp
  case action
    when "profile"
      puts "Do you want to view your collection('C'), view your favorite movie ('F'), set your favorite movie('S'), or get your favorite genre('G')?"
      action=gets.chomp
      case action
        when "C"
          puts "Here are the movies in your collection: #{User.movies}"
        when "F"
          puts "Your favorite movie is #{User.favorite_movie}"
        when "S"
          puts "What is your favorite movie?"
          User.favorite_movie=gets.chomp
          puts "Your favorite movie is now listed as #{User.favorite_movie}"
        when "G"
          puts "Your favorite genre is #{User.get_favorite_genre}."
      end
    when "collection"
      puts "Do you want to add a movie('A'), lookup a movie ('L'), or remove a movie ('R')?"
      action=gets.chomp
      case action
        when 'A'
          controller = UserController.new
          controller.add_movie(user)
      end
  end 
end