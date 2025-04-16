require_relative '../lib/roll_result'
require_relative '../lib/die'

RSpec.describe RollResult do
  it "generates correct output" do
    dice = [Die.new(6), Die.new(8)]
    values = [4, 5]
    result = RollResult.new(dice, values)

    expect(result.total).to eq(9)
    expect(result.to_s).to include("6-sided: 4")
    expect(result.to_s).to include("8-sided: 5")
  end
end