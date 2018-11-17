require_relative "player"
require "set"
# require_relative "dictionary"

class Game
  attr_reader :current_player, :fragment, :dictionary # keep :dict for now, maybe take out when playing
  attr_writer :fragment # just for debuggin, get rid of this for final
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

  def valid_play?(char)
    alphabet = ("a".."z")
    if !alphabet.include?(char.downcase)
      puts "that's not a letter..."
      return false
    end

    cur_idx = @fragment.length
    @dictionary.each do |word|
      if word.include?(@fragment) && word[cur_idx] == char.downcase
        return true
      end
    end

    puts "try a different letter"
    false
  end

  # def

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
