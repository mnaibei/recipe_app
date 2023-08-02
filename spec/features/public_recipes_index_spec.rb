require 'rails_helper'

RSpec.feature 'Public Recipes Page', type: :feature do
  include Devise::Test::IntegrationHelpers
  let(:user) { FactoryBot.create(:user) }
  let(:public_recipe1) { FactoryBot.create(:recipe, public: true, user:) }
  let(:public_recipe2) { FactoryBot.create(:recipe, public: true, user:) }

  scenario 'displays public recipes details' do
    # Create some public recipes
    public_recipe1
    public_recipe2

    # Sign in as the user
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    # Visit the public recipes page
    visit public_recipes_path

    # Check that the page title is displayed
    expect(page).to have_content('Public Recipes')

    # Check that the public recipes details are displayed correctly
    expect(page).to have_content(public_recipe1.name)
    expect(page).to have_content(public_recipe1.user.name)
    expect(page).to have_content("Total food items: #{public_recipe1.recipe_foods.count}")
    total_price = public_recipe1.recipe_foods.joins(:food).sum('foods.price * recipe_foods.quantity').to_i
    expect(page).to have_content("Total price: $ #{total_price}")

    expect(page).to have_content(public_recipe2.name)
    expect(page).to have_content(public_recipe2.user.name)
    expect(page).to have_content("Total food items: #{public_recipe2.recipe_foods.count}")
    total_price = public_recipe2.recipe_foods.joins(:food).sum('foods.price * recipe_foods.quantity').to_i
    expect(page).to have_content("Total price: $ #{total_price}")
  end
end
