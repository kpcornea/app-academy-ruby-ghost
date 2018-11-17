require_relative "player"
require "set"
# require_relative "dictionary"

class Game
  attr_reader :current_player, :fragment

  def initialize(player1, player2)
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)
    # maybe make @players array for for than 2 players and iterate through to get next player
    @current_player = @player1
    @fragment = ""
    @dictionary = Set[]
    File.foreach("dictionary.txt") { |line| @dictionary.add(line.chomp) }
  end

  # def current_player
  #   @current_player
  # end

  # def previous_player
  #   @player2
  # end

  def next_player!
    if @current_player = @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def take_turn(player)
    guess = gets.chomp # switch to Player class?
    if valid_play?(guess)
      @fragment += guess
      return true
    end
    false
  end

  def valid_play?(str)
    alphabet = ("a".."z")
    if alphabet.include?(str) && @dictionary # words we can spell after adding it to fragment, think i need array lookup for this one
      return true
    end
    false
  end

  def match?(str)
    @dictionary === str
  end

  # def play_round
  #
  # end

  # def lose?
  #   if # relative to other player. actually probably shouldn't do it like this cuz 1 will win, 1 will lose
  #
  # end
  #
  # def win?
  #
  # end

  def over?(str) # param for this?
    if match?(str) # like this or just if word is selected?
      puts "#{@current_player} wins!"
      return true
    end
    false
  end



end
