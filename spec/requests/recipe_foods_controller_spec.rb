require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let(:food) { FactoryBot.create(:food) }

  describe 'GET #new' do
    it 'returns a successful response' do
      sign_in user
      get new_recipe_recipe_food_path(recipe)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new recipe_food' do
      sign_in user
      expect do
        post recipe_recipe_foods_path(recipe), params: { recipe_food: { food_id: food.id, quantity: 1 } }
      end.to change(RecipeFood, :count).by(1)

      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq('Ingredient was added successfully.')
    end

    it 'renders new template with unprocessable_entity status if invalid params are passed' do
      sign_in user
      expect do
        post recipe_recipe_foods_path(recipe), params: { recipe_food: { food_id: nil, quantity: 1 } }
      end.not_to change(RecipeFood, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
