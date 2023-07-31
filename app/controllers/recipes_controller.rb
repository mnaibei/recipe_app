class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  # def new
  #   @recipe = Recipe.new
  # end

  # def create
  #   @recipe = Recipe.new(recipe_params)
  #   @recipe.user = current_user

  #   if @recipe.save
  #     redirect_to recipe_path(@recipe), notice: 'Recipe was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_url, notice: 'Recipe was successfully deleted.'
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)

    redirect_to recipe_path(@recipe)
  end

  def generate_shopping_list
    @recipe = Recipe.find(params[:recipe_id])
    @shopping_list_items = @recipe.generate_shopping_list_items
  end

  private

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
