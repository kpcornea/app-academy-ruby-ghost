require_relative "player"
require_relative "game"

puts "player1's name?"
player1 = gets.chomp
puts "player2's name?"
player2 = gets.chomp


ghost = Game.new(player1, player2)
# p ghost
until ghost.over?
  ghost.next_player! unless ghost.fragment == ""
  puts "-------------"
  puts "enter a character #{ghost.current_player.name}"
  ghost.take_turn(ghost.current_player)
  puts "current fragment: #{ghost.fragment}"
end
