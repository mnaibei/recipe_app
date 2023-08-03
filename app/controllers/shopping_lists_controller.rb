class ShoppingListsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @recipe_foods = @user.recipes.joins(recipe_foods: :food).select('recipe_foods.*, recipes.name AS recipe_name,
      foods.name AS food_name, foods.price AS food_price, foods.quantity AS food_quantity,
      foods.measurement_unit AS measurement_unit').to_a

    unique_recipe_foods = Set.new

    @recipe_foods.each do |recipe_food|
      existing_recipe_food = unique_recipe_foods.find { |rf| rf.food_name == recipe_food.food_name }

      if existing_recipe_food
        existing_recipe_food.quantity += recipe_food.quantity
      else
        unique_recipe_foods.add(recipe_food)
      end

      # Use abs method to ensure the quantity is positive
      recipe_food.quantity = recipe_food.quantity.abs
      recipe_food.quantity -= recipe_food.food_quantity

      # Use abs method to ensure the price is positive
      recipe_food.food_price = recipe_food.food_price.abs
    end

    @recipe_foods = unique_recipe_foods.to_a

    @shopping_list_count = @recipe_foods.count
    @total_price = @recipe_foods.sum { |recipe_food| recipe_food.food_price * recipe_food.quantity }
  end
end
