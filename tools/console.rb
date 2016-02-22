require '../config/environment.rb'

def reload!
  load('../config/environment.rb')
end

Pry.start
end