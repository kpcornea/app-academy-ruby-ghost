require_relative "player"
require "set"

class Game
  attr_reader :current_player, :fragment

  def initialize(players)
    @players = []
    players.each do |player|
      @players << Player.new(player)
    end

    @current_player = @players[0]
    @fragment = ""

    @dictionary = Set[]
    File.foreach("dictionary.txt") { |line| @dictionary.add(line.chomp) }

    @losses = {}
    @players.each do |player|
      @losses[player.name] = 0
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
    if @players.length == 1
      puts "#{@players[0].name} WINS IT ALL!!"
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

      @losses.each do |player, losses|
        @losses[player] += 1 if player != @current_player.name && losses < 5
      end

      @losses.each_key do |player|
        puts "#{player}'s progress towards GHOST: #{record(player)}"
      end

      @fragment = ""
      kick_losers!
    end
  end

  def record(player)
    str = "GHOST"
    length = @losses[player]
    str[0...length]
  end

  def kick_losers!
    @players.select! do |player|
      @losses[player.name] < 5
    end
  end

end
