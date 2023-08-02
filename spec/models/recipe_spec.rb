require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'is valid with a name and associated user' do
    recipe = described_class.new(name: 'Apple Pie', user:)
    expect(recipe).to be_valid
  end

  it 'is invalid without a name' do
    recipe = described_class.new(user:)
    expect(recipe).not_to be_valid
    expect(recipe.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without an associated user' do
    recipe = described_class.new(name: 'Apple Pie')
    expect(recipe).not_to be_valid
    expect(recipe.errors[:user]).to include('must exist')
  end
end
