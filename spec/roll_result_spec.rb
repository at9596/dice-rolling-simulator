# spec/roll_result_spec.rb
require 'spec_helper'

RSpec.describe RollResult do
  let(:d6_1) { Die.new(6) }
  let(:d6_2) { Die.new(6) }
  let(:d20) { Die.new(20) }

  describe '#initialize' do
    it 'stores the dice and values' do
      dice = [d6_1]
      values = [4]
      result = RollResult.new(dice, values)
      expect(result.dice).to eq(dice)
      expect(result.values).to eq(values)
    end

    it 'raises ArgumentError if dice and values counts mismatch' do
      expect { RollResult.new([d6_1], [4, 5]) }.to raise_error(ArgumentError)
      expect { RollResult.new([d6_1, d6_2], [4]) }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError if dice or values are not arrays' do
      expect { RollResult.new(nil, [4]) }.to raise_error(ArgumentError)
      expect { RollResult.new([d6_1], nil) }.to raise_error(ArgumentError)
    end
  end

  describe '#total' do
    it 'calculates the sum of the values' do
      result = RollResult.new([d6_1, d6_2, d20], [3, 5, 18])
      expect(result.total).to eq(3 + 5 + 18) # 26
    end

    it 'returns 0 if values array is empty' do
      result = RollResult.new([], [])
      expect(result.total).to eq(0)
    end
  end

  describe '#description' do
    it 'describes a single type of die' do
      result = RollResult.new([d6_1, d6_2], [3, 5])
      expect(result.description).to eq('2d6')
    end

    it 'describes multiple types of dice' do
      dice = [d6_1, d20, d6_2] # Deliberately unsorted
      result = RollResult.new(dice, [3, 18, 5])
      expect(result.description).to eq('2d6 + 1d20') # Assumes sorting by sides
    end

     it 'describes multiple types of dice including single dice' do
      d8 = Die.new(8)
      dice = [d6_1, d20, d6_2, d8]
      result = RollResult.new(dice, [3, 18, 5, 7])
      expect(result.description).to eq('2d6 + 1d8 + 1d20') # Assumes sorting
    end

    it 'returns "No dice rolled" for empty dice array' do
       result = RollResult.new([], [])
       expect(result.description).to eq('No dice rolled')
    end
  end
end