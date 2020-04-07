# PHASE 2
def convert_to_int(str)
  Integer(str)
  rescue 
    return nil 
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  else 
    raise ArgumentError.new("Thanks for the coffee, but a fruit please.") if maybe_fruit == "coffee"
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  begin 
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue ArgumentError => e 
    puts "Error was: #{e.message}"  
    retry 
  end 
end  

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    raise ArgumentError.new("Give me a real name!") if name == ""
    @yrs_known = yrs_known
    raise ArgumentError.new("We haven't been friends for long :/") if yrs_known < 5 
    @fav_pastime = fav_pastime
    raise ArgumentError.new("Give me a real pastime!") if fav_pastime == ""
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


