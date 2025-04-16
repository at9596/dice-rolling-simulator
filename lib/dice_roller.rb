# lib/dice_roller.rb
require_relative 'die'
require_relative 'roll_result'

class DiceRoller
  # Initializes a DiceRoller with a collection of dice.
  #
  # @param dice [Array<Die>] An array of Die objects to be rolled.
  def initialize(dice = [])
    unless dice.is_a?(Array) && dice.all? { |d| d.is_a?(Die) }
      raise ArgumentError, "DiceRoller must be initialized with an array of Die objects"
    end
    @dice = dice
  end

  # Rolls all the dice held by the roller.
  #
  # @return [RollResult] An object containing the details of the roll.
  def roll
    # Call roll on each die object and collect the results
    values = @dice.map(&:roll)
    # Return a new RollResult containing the dice and their values
    RollResult.new(@dice, values)
  end
end