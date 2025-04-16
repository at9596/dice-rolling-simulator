require_relative '../lib/die'

RSpec.describe Die do
  it "rolls a value within range" do
    die = Die.new(6)
    100.times do
      expect(die.roll).to be_between(1, 6)
    end
  end

  it "raises error for invalid sides" do
    expect { Die.new(1) }.to raise_error(ArgumentError)
  end
end