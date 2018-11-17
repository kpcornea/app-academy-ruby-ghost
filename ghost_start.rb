require_relative "player"
require_relative "game"

puts "player1's name?"
player1 = gets.chomp
puts "player2's name?"
player2 = gets.chomp


ghost = Game.new(player1, player2)
p ghost
# # until game.over?
#   puts "-------------"
#   puts "enter a character"
#   game.take_turn
#   game.next_player!
#   puts game.fragment
# end
