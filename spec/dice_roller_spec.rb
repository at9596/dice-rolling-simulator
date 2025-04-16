require_relative '../lib/dice_roller'

RSpec.describe DiceRoller do
  it "rolls multiple dice and returns a valid RollResult" do
    roller = DiceRoller.new
    roller.add_die(6, 2)
    result = roller.roll

    expect(result.values.length).to eq(2)
    expect(result.total).to eq(result.values.sum)
  end
end