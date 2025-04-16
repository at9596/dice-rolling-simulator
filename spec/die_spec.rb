# spec/die_spec.rb
require 'spec_helper'

RSpec.describe Die do
  describe '#initialize' do
    it 'creates a die with the specified number of sides' do
      die = Die.new(6)
      expect(die.sides).to eq(6)
    end

    it 'raises an ArgumentError for fewer than 2 sides' do
      expect { Die.new(1) }.to raise_error(ArgumentError, /must have at least 2 sides/i)
      expect { Die.new(0) }.to raise_error(ArgumentError, /must have at least 2 sides/i)
      expect { Die.new(-5) }.to raise_error(ArgumentError, /must have at least 2 sides/i)
    end

    it 'raises an ArgumentError for non-integer sides' do
      expect { Die.new(nil) }.to raise_error(ArgumentError, /must have at least 2 sides/i)
      expect { Die.new('abc') }.to raise_error(ArgumentError, /must have at least 2 sides/i)
      expect { Die.new(3.5) }.to raise_error(ArgumentError, /must have at least 2 sides/i)
    end
  end

  describe '#roll' do
    let(:sides) { 6 }
    let(:die) { Die.new(sides) }

    it 'returns an integer' do
      expect(die.roll).to be_an(Integer)
    end

    it 'returns a value between 1 and the number of sides (inclusive)' do
      100.times do # Roll multiple times to increase confidence
        roll_value = die.roll
        expect(roll_value).to be >= 1
        expect(roll_value).to be <= sides
        # Alternative RSpec matcher:
        expect(roll_value).to be_between(1, sides).inclusive
      end
    end

    it 'returns different values over multiple rolls (probabilistic)' do
      # Testing true randomness is hard. This checks for *some* variation.
      rolls = Array.new(20) { die.roll }
      unique_rolls = rolls.uniq
      # It's highly unlikely a 6-sided die rolled 20 times gives only 1 result.
      expect(unique_rolls.count).to be > 1
    end
  end

  describe '#to_s' do
    it 'returns a string representation like "d6"' do
      expect(Die.new(6).to_s).to eq('d6')
      expect(Die.new(20).to_s).to eq('d20')
    end
  end
end