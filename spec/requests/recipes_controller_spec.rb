require 'rails_helper'

RSpec.describe RecipesController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  describe 'GET #index' do
    it 'returns a successful response' do
      sign_in user
      get recipes_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      recipe = FactoryBot.create(:recipe, user:)
      sign_in user
      get recipe_path(recipe)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      sign_in user
      get new_recipe_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new recipe' do
        sign_in user
        recipe_params = FactoryBot.attributes_for(:recipe)
        expect do
          post recipes_path, params: { recipe: recipe_params }
        end.to change(Recipe, :count).by(1)
      end

      it 'redirects to the index page' do
        sign_in user
        recipe_params = FactoryBot.attributes_for(:recipe)
        post recipes_path, params: { recipe: recipe_params }
        expect(response).to redirect_to(recipes_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new recipe' do
        sign_in user
        expect do
          post recipes_path, params: { recipe: { name: '' } }
        end.not_to change(Recipe, :count)
      end

      it 'renders the new template with unprocessable_entity status' do
        sign_in user
        post recipes_path, params: { recipe: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the recipe' do
      recipe = FactoryBot.create(:recipe, user:)
      sign_in user
      expect do
        delete recipe_path(recipe)
      end.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the index page' do
      recipe = FactoryBot.create(:recipe, user:)
      sign_in user
      delete recipe_path(recipe)
      expect(response).to redirect_to(recipes_path)
    end
  end
end
