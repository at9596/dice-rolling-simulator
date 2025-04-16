
require_relative 'die'
require_relative 'roll_result'

class DiceRoller
  def initialize(dice = [])
    @dice = dice
  end

  def add_die(sides, count = 1)
    count.times { @dice << Die.new(sides) }
  end

  def roll
    values = @dice.map(&:roll)
    RollResult.new(@dice, values)
  end
end