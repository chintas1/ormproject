require_relative '../config/environment.rb'

puts "Welcome to your movie collection manager."
puts "Please enter a username to create your profile."
# creates a new user object, runs the 'welcome' user view
username = gets.chomp
puts "Welcome #{username}!"

puts "Please enter your favorite movie."
fav_movie = gets.chomp
puts ""
