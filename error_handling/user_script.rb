require_relative 'super_useful'

puts "'five' == #{convert_to_int('five')}"

feed_me_a_fruit
begin
    sam = BestFriend.new('', 1, '')
rescue ArgumentError => e
    puts "Error was: #{e.message}"
ensure 
    sam = BestFriend.new("Samantha", 6, "basketweaving")
end

sam.talk_about_friendship
sam.do_friendstuff
sam.give_friendship_bracelet
