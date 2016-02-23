class UserPromptView
  def render
    puts "\nUsers list:"
    puts User.all.map {|user| user.name}.join(", ")
    puts "Enter the name of the user you want to compare to."
    gets.chomp
  end
end