# spec/dice_roller_spec.rb
require 'spec_helper'

RSpec.describe DiceRoller do
  let(:d6_1) { instance_double(Die, sides: 6) } # Use doubles for isolation
  let(:d6_2) { instance_double(Die, sides: 6) }
  let(:d20) { instance_double(Die, sides: 20) }

  describe '#initialize' do
    it 'initializes with an array of Die objects' do
      dice = [Die.new(6), Die.new(20)] # Use real Die objects here for type check
      roller = DiceRoller.new(dice)
      # No public accessor for @dice by default, test behavior via #roll
      expect { roller.roll }.not_to raise_error
    end

    it 'initializes with an empty array by default' do
       roller = DiceRoller.new
       result = roller.roll
       expect(result).to be_a(RollResult)
       expect(result.values).to be_empty
    end

    it 'raises ArgumentError if not given an array' do
       expect { DiceRoller.new(nil) }.to raise_error(ArgumentError)
       expect { DiceRoller.new("not array") }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError if array contains non-Die objects' do
       expect { DiceRoller.new([Die.new(6), "not a die"]) }.to raise_error(ArgumentError)
    end
  end

  describe '#roll' do
    it 'returns a RollResult object' do
      roller = DiceRoller.new([Die.new(6)]) # Use real Die
      expect(roller.roll).to be_a(RollResult)
    end

    it 'calls roll on each die in the collection' do
      # Use doubles/mocks to verify interaction
      expect(d6_1).to receive(:roll).once.and_return(4)
      expect(d6_2).to receive(:roll).once.and_return(2)
      expect(d20).to receive(:roll).once.and_return(15)

      dice = [d6_1, d6_2, d20]
      roller = DiceRoller.new(dice)
      roller.roll
    end

    it 'returns a RollResult containing the original dice' do
       dice = [Die.new(6), Die.new(20)] # Use real dice
       roller = DiceRoller.new(dice)
       result = roller.roll
       expect(result.dice).to eq(dice)
    end

    it 'returns a RollResult with values from each die roll' do
      # Stub roll calls on doubles
      allow(d6_1).to receive(:roll).and_return(4)
      allow(d6_2).to receive(:roll).and_return(2)
      allow(d20).to receive(:roll).and_return(15)

      dice = [d6_1, d6_2, d20]
      roller = DiceRoller.new(dice)
      result = roller.roll

      expect(result.values).to eq([4, 2, 15])
    end

     it 'handles rolling an empty set of dice' do
       roller = DiceRoller.new([])
       result = roller.roll
       expect(result).to be_a(RollResult)
       expect(result.dice).to be_empty
       expect(result.values).to be_empty
       expect(result.total).to eq(0)
       expect(result.description).to eq("No dice rolled")
    end
  end
end