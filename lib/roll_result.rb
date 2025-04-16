# lib/roll_result.rb
require 'byebug'
class RollResult
  attr_reader :dice, :values

  # Initializes a RollResult.
  #
  # @param dice [Array<Die>] The collection of dice that were rolled.
  # @param values [Array<Integer>] The individual results from each die roll.
  def initialize(dice, values)
    # byebug
    # Basic validation, more robust checks could be added
    unless dice.is_a?(Array) && values.is_a?(Array) && dice.count == values.count
      raise ArgumentError, "Mismatched dice and values provided to RollResult"
    end
    @dice = dice
    @values = values
  end

  # Calculates the sum of all individual die roll values.
  #
  # @return [Integer] The total sum.
  def total
    # byebug
    @values.sum
  end

  # Generates a description of the dice that were rolled (e.g., "2d6 + 1d20").
  # Groups dice by their number of sides.
  #
  # @return [String] A description string.
  def description
    return "No dice rolled" if @dice.empty?

    @dice.group_by(&:sides)
         .sort_by { |sides, _| sides } # Sort by sides for consistent output
         .map { |sides, dice_group| "#{dice_group.count}d#{sides}" }
         .join(' + ')
  end
end