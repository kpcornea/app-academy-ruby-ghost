class Player
  attr_reader :losses, :wins

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
    puts "dam you suck :c"
  end

  def won
    @wins += 1
    puts "wow the other player must feel bad c:"
  end
  
end
