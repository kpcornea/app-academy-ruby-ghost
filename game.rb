require_relative "player"
require "set"

class Game
  attr_reader :current_player, :fragment, :dictionary # keep :dict for now, maybe take out when playing
  attr_writer :fragment # just for debuggin, get rid of this for final

  # def initialize(player1, player2)
  def initialize(players)
    # @player1 = Player.new(player1)
    # @player2 = Player.new(player2)
    @players = []
    players.each_with_index do |player, i|
      @players << Player.new(player)
    end
    # maybe make @players array for for than 2 players and iterate through to get next player
    @current_player = @players[0]
    @previous_player = @players[1] # maybe don't need, will keep for now for multiplayer possibility
    @fragment = ""
    @dictionary = Set[]
    File.foreach("dictionary.txt") { |line| @dictionary.add(line.chomp) }
    # @losses = { @player1.name => @player1.losses, @player2.name => @player2.losses }
    @losses = {}
    @players.each do |player|
      @losses[player.name] = player.losses
    end
  end

  def next_player!
    cur_idx = @players.index(@current_player)
    @current_player = @players[(cur_idx + 1) % @players.length]
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
    if @losses.values.include?(5)
      puts "#{@current_player.name} WINS IT ALL!!"
      return true
    end
    false
  end

  def play_round
    next_player! unless @fragment == ""
    puts "-------------"
    puts "enter a character #{@current_player.name}"
    take_turn(@current_player)
    puts "current fragment: #{@fragment}"
    if match?(@fragment)
      puts "#{@current_player.name} wins this round!"
      @losses[@previous_player.name] += 1
      puts "#{@current_player.name}'s progress towards GHOST: #{record(@current_player)}"
      puts "#{@previous_player.name}'s progress towards GHOST: #{record(@previous_player)}"
      @fragment = ""
    end
  end

  def record(player)
    str = "GHOST"
    length = @losses[player.name]
    str[0...length]
  end

  # def run
  #
  # end

end
