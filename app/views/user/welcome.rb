class UserWelcomeView
  def render(current_user)
    puts "\nWelcome #{current_user.name}"
  end

end