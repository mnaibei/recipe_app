require 'rails_helper'

RSpec.describe FoodsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get foods_url
      expect(response).to be_successful
    end

    it 'assigns user foods to @foods' do
      user_food1 = FactoryBot.create(:food, user:)
      user_food2 = FactoryBot.create(:food, user:)
      FactoryBot.create(:food)

      get foods_url
      expect(assigns(:foods)).to match_array([user_food1, user_food2])
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get new_food_url
      expect(response).to be_successful
    end

    it 'assigns a new Food to @food' do
      get new_food_url
      expect(assigns(:food)).to be_a_new(Food)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new food' do
        food_params = FactoryBot.attributes_for(:food)
        expect do
          post foods_url, params: { food: food_params }
        end.to change(Food, :count).by(1)
      end

      it 'redirects to the foods index page' do
        food_params = FactoryBot.attributes_for(:food)
        post foods_url, params: { food: food_params }
        expect(response).to redirect_to(foods_url)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new food' do
        invalid_food_params = { name: '', measurement_unit: 'grams', price: -5.0, quantity: 0 }
        expect do
          post foods_url, params: { food: invalid_food_params }
        end.not_to change(Food, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the food' do
      food = FactoryBot.create(:food, user:)
      expect do
        delete food_url(food)
      end.to change(Food, :count).by(-1)
    end

    it 'redirects to the foods index page' do
      food = FactoryBot.create(:food, user:)
      delete food_url(food)
      expect(response).to redirect_to(foods_url)
    end
  end
end
