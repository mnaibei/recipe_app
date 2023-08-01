require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'is valid with a user' do
    food = FactoryBot.create(:food, user:)
    expect(food).to be_valid
  end

  it 'is invalid without a user' do
    food = FactoryBot.build(:food, user: nil)
    expect(food).not_to be_valid
    expect(food.errors[:user]).to include('must exist')
  end

  it 'has many recipe foods' do
    food = FactoryBot.create(:food, user:)
    recipe_food1 = FactoryBot.create(:recipe_food, food:)
    recipe_food2 = FactoryBot.create(:recipe_food, food:)

    expect(food.recipe_foods).to include(recipe_food1, recipe_food2)
  end
end
