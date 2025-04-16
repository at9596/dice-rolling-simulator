require 'byebug'
class Die
  attr_reader :sides

  def initialize(sides)
    unless sides.is_a?(Integer) && sides >= 2
      raise ArgumentError, "Die must have at least 2 sides (received: #{sides.inspect})"
    end
    @sides = sides
  end

  # Rolls the die once.
  #
  # @return [Integer] a random integer between 1 and the number of sides (inclusive).
  def roll
    # byebug
    rand(1..@sides)
  end

  # Provides a simple string representation (e.g., "d6").
  #
  # @return [String]
  def to_s
    # byebug
    "d#{@sides}"
  end
end