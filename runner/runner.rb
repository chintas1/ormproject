require_relative '../config/environment.rb'
puts "Welcome to your movie collection manager."


puts "Please enter a username to create or access your profile."

controller = UserController.new
user = controller.new_user

action=""
while action != "exit"
  puts "Do you want to work on your profile, collection, or exit?"
  action=gets.chomp
  case action
    when "profile"
      puts "Do you want to view your collection('C'), view your favorite movie ('F'), set your favorite movie('S'), or get your favorite genre('G')?"
      action=gets.chomp
      case action
        when "C"
          controller = MoviesController.new
          controller.display_collection(user)
        when "F"
          controller = UserController.new
          controller.find_fav_movie(user)
        when "S"
          controller = MoviesController.new
          controller.set_fav_movie(user)
        when "G"
          controller = UserController.new
          controller.get_fav_genre(user)
      end
    when "collection"
      puts "Do you want to add a movie('A'), lookup a movie ('L'), or remove a movie ('R')?"
      action=gets.chomp
      case action
        when 'A'
          controller = MoviesController.new
          controller.add_movie(user)
        when 'L'
          controller = MoviesController.new
          controller.lookup_movie
        when 'R'
          controller = MoviesController.new
          controller.remove_movie(user)
      end
  end 
end