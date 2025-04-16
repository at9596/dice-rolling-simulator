class Die
  # Use attr_reader to create a getter for the sides instance variable
  attr_reader :sides
  def initialize(sides)
    raise ArgumentError, " Die must have at least 1 side" if sides < 1
    raise ArgumentError, " Die must have at least 2 sides" if sides == 1
    @sides = sides if sides < 2 
  end

  def roll
    rand(1..@sides)
  end

end