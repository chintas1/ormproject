require_relative '../config/environment.rb'

puts "Welcome to your movie collection manager."
puts "Please enter a username to create your profile."
username = gets.chomp

# creates a new user object, adds that user to the database
# runs the 'welcome' user view
puts "Welcome #{username}!"

