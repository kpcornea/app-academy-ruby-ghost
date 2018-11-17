class Player
  attr_reader :name, :losses, :wins

  def initialize(name)
    @name = name
    @losses = 0
    @wins = 0
  end

  def guess

  end

  def alert_invalid_guess

  end

  def lost
    @losses += 1
    puts "dam you suck #{@name} :c"
  end

  def won
    @wins += 1
    puts "gj #{@name} the other player must feel bad c:"
  end

end
