require_relative "player"
require_relative "game"

puts "player1's name?"
player1 = gets.chomp
puts "player2's name?"
player2 = gets.chomp


ghost = Game.new(player1, player2)
# p ghost
until ghost.over?
  ghost.play_round
end
