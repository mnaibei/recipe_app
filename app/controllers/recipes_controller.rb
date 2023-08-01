class RecipesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = @recipe.user
    @recipe_foods = @recipe.recipe_foods
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe Created Successfully' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
