require 'rails_helper'

RSpec.feature 'Recipe Show Page', type: :feature do
  include Capybara::RSpecMatchers
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let!(:food) { FactoryBot.create(:food, name: 'Ingredient 1') }

  scenario 'displays recipe details and food items' do
    recipe_food = FactoryBot.create(:recipe_food, recipe:, food:)

    # Sign in as the user
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    # Visit the recipe show page
    visit recipe_path(recipe)

    # Check that the recipe details are displayed
    expect(page).to have_content(recipe.name)
    expect(page).to have_content("Preparation Time: #{recipe.preparation_time.strftime('%H:%M:%S')}")
    expect(page).to have_content("Cooking Time: #{recipe.cooking_time.strftime('%H:%M:%S')}")
    expect(page).to have_content("Description: #{recipe.description}")
    expect(page).to have_content("Created By: #{recipe.user.name}")
    expect(page).to have_button('Generate shopping list', disabled: false)
    expect(page).to have_button('Add ingredient', disabled: false)
    expect(page).to have_content(food.name)
    expect(page).to have_content("$ #{recipe_food.food.price * recipe_food.quantity}")
  end
end
