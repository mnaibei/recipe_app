require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:recipe) { FactoryBot.create(:recipe) }
  let(:food) { FactoryBot.create(:food) }

  it 'is valid with a quantity, recipe, and food' do
    recipe_food = described_class.new(quantity: 2, recipe:, food:)
    expect(recipe_food).to be_valid
  end

  it 'is invalid without a quantity' do
    recipe_food = described_class.new(recipe:, food:)
    expect(recipe_food).not_to be_valid
    expect(recipe_food.errors[:quantity]).to include("can't be blank")
  end

  it 'is invalid with a non-positive quantity' do
    recipe_food = described_class.new(quantity: 0, recipe:, food:)
    expect(recipe_food).not_to be_valid
    expect(recipe_food.errors[:quantity]).to include('must be greater than 0')
  end

  it 'is invalid without an associated recipe' do
    recipe_food = described_class.new(quantity: 2, food:)
    expect(recipe_food).not_to be_valid
    expect(recipe_food.errors[:recipe]).to include('must exist')
  end

  it 'is invalid without an associated food' do
    recipe_food = described_class.new(quantity: 2, recipe:)
    expect(recipe_food).not_to be_valid
    expect(recipe_food.errors[:food]).to include('must exist')
  end
end
