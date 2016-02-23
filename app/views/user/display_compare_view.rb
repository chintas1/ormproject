class DisplayCompareView
  def render(your_list, other_list, other_name)
    puts "\nMovies in common:"
    puts "#{(your_list & other_list).join(", ")}"
    puts "-------------------------------"
    puts "Movies unique to you:"
    puts "#{(your_list - other_list).join(", ")}"
    puts "-------------------------------"
    puts "Movies unique to #{other_name}:"
    puts "#{(other_list - your_list).join(", ")}"
    puts "-------------------------------"
  end
end