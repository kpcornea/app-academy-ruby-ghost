require_relative "player"
require "set"

class Game
  attr_reader :current_player, :fragment, :dictionary # keep :dict for now, maybe take out when playing
  attr_writer :fragment # just for debuggin, get rid of this for final

  def initialize(player1, player2)
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)
    # maybe make @players array for for than 2 players and iterate through to get next player
    @current_player = @player1
    @previous_player = @player2 # maybe don't need, will keep for now for multiplayer possibility
    @fragment = ""
    @dictionary = Set[]
    File.foreach("dictionary.txt") { |line| @dictionary.add(line.chomp) }
  end

  def next_player!
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def take_turn(player)
    guess = gets.chomp
    if valid_play?(guess)
      @fragment += guess
    else
      take_turn(player)
    end
  end

  def valid_play?(char)
    alphabet = ("a".."z")
    if !alphabet.include?(char.downcase)
      puts "that's not a letter..."
      return false
    end

    cur_idx = @fragment.length
    @dictionary.each do |word|
      if word[0...cur_idx] == @fragment && word[cur_idx] == char.downcase
        return true
      end
    end

    puts "try a different letter"
    false
  end

  def match?(str)
    @dictionary === str
  end

  def over?
    if match?(@fragment)
      puts "#{@current_player.name} wins!"
      return true
    end
    false
  end

end
