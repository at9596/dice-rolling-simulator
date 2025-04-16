class RollResult
  attr_reader :dice_descriptions, :values, :total

  def initialize(dice, values)
    @dice_descriptions = dice.map { |die| "#{die.sides}-sided" }
    @values = values
    @total = values.sum
  end

  def to_s
    # Use the map method to create an array of strings for each die description and value
    # Then join them with a comma and add the total at the end
    # Use string interpolation to format the output
    descriptions = dice_descriptions.zip(values).map { |desc, val| "#{desc}: #{val}" }
    "#{descriptions.join(', ')} | Total: #{total}"
  end
end