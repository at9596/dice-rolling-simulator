#!/usr/bin/env ruby

# Load files from the lib directory
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'die'
require 'dice_roller'
require 'roll_result' # Though DiceRoller requires it, good to be explicit

# Helper method to prompt user for an integer with basic validation
def prompt_integer(message)
  print message
  loop do
    input = gets.chomp
    begin
      value = Integer(input)
      return value # Return the valid integer
    rescue ArgumentError
      puts "Invalid input. Please enter a whole number."
      print message # Re-prompt
    end
  end
end

puts "Welcome to the Dice Rolling Simulator!"
puts "-" * 40

all_dice = [] # Array to hold all the Die objects we create

types_of_dice = 0
loop do
  types_of_dice = prompt_integer("How many different types of dice do you want to roll? (e.g., 1 for only d6, 2 for d6 and d20, etc.): ")
  break if types_of_dice >= 0 # Allow 0 types, though it won't roll anything
  puts "Please enter a non-negative number."
end


if types_of_dice == 0
  puts "\nNo dice types specified. Exiting."
  exit
end

types_of_dice.times do |i|
  puts "\n--- Die Type ##{i + 1} ---"
  num_dice = -1
  loop do
    num_dice = prompt_integer("Enter number of dice for this type: ")
    break if num_dice > 0
    puts "Please enter a positive number of dice."
  end

  num_sides = -1
  loop do
    num_sides = prompt_integer("Enter number of sides for this type (e.g., 6, 8, 20): ")
    begin
      # Attempt to create a dummy die to validate sides > 1
      Die.new(num_sides)
      break # If Die.new doesn't raise error, sides are valid
    rescue ArgumentError => e
      puts "Invalid input: #{e.message}. Please try again."
    end
  end

  # Create the Die objects and add them to the main list
  puts "Adding #{num_dice} dice with #{num_sides} sides..."
  begin
    num_dice.times { all_dice << Die.new(num_sides) }
  rescue ArgumentError => e
    # Should be caught by loop above, but as a safeguard
     puts "Error creating die: #{e.message}. Skipping this type."
  end
end

puts "\n" + "-" * 40
if all_dice.empty?
   puts "No valid dice were configured to roll."
else
  # Create the roller and perform the roll
  roller = DiceRoller.new(all_dice)
  result = roller.roll

  # Display results
  puts "Rolling: #{result.description}"
  puts "-" * 40
  puts "Individual rolls: #{result.values.join(', ')}"
  puts "Total: #{result.total}"
  puts "-" * 40
end

puts "Thank you for using the Dice Rolling Simulator!"