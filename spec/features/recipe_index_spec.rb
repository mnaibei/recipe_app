require 'rails_helper'

RSpec.feature 'Recipes Index Page', type: :feature do
  let!(:user) { FactoryBot.create(:user) }

  scenario 'displays recipes created by the logged-in user' do
    recipe1 = FactoryBot.create(:recipe, user:, name: 'Recipe 1', description: 'Description 1')
    recipe2 = FactoryBot.create(:recipe, user:, name: 'Recipe 2', description: 'Description 2')

    other_user_recipe = FactoryBot.create(:recipe, name: 'Other User Recipe', description: 'Other User Description')

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit recipes_path

    expect(page).to have_content(recipe1.name)
    expect(page).to have_content(recipe1.description)
    expect(page).to have_content(recipe2.name)
    expect(page).to have_content(recipe2.description)
    expect(page).not_to have_content(other_user_recipe.name)
    expect(page).not_to have_content(other_user_recipe.description)
    expect(page).to have_link('New Recipe', href: new_recipe_path)
    expect(page).to have_selector('.delete', count: 2)
  end
end
