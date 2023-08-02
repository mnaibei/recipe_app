require 'rails_helper'

RSpec.feature 'Shopping List Page', type: :feature do
  include Devise::Test::IntegrationHelpers
  let(:user) { FactoryBot.create(:user) }
  let(:food1) { FactoryBot.create(:food, price: 5, quantity: 10) }
  let(:food2) { FactoryBot.create(:food, price: 8, quantity: 15) }
  let(:recipe1) { FactoryBot.create(:recipe, user:) }
  let(:recipe2) { FactoryBot.create(:recipe, user:) }
  let!(:recipe_food1) { FactoryBot.create(:recipe_food, recipe: recipe1, food: food1, quantity: 2) }
  let!(:recipe_food2) { FactoryBot.create(:recipe_food, recipe: recipe2, food: food2, quantity: 3) }

  before do
    sign_in user
    visit shopping_lists_path
  end

  scenario 'displays shopping list' do
    # Check that the page title is displayed
    expect(page).to have_content('Shopping List')
    expect(page).to have_content(food1.name)
    expect(page).to have_content(food2.name)
  end
end
