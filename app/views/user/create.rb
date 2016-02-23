class UserCreateView
  def render
    puts "\n----------------------------"
    puts "-------- YOUR MOVIE --------"
    puts "-------- COLLECTION --------"
    puts "--------- MANAGER ----------"
    puts "----------------------------"
    puts "\nEnter your username to load up your info or create a new user."
    gets.chomp
  end

end