require_relative "player"
require_relative "game"

players = []
i = 1
done = false

until done
  puts "player#{i}'s name?"
  player = gets.chomp
  players << player

  puts "is that it? Enter y or n"
  answer = gets.chomp
  done = true if answer == "y"
  i += 1
end

ghost = Game.new(players)

until ghost.over?
  ghost.play_round
end
