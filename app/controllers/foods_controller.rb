class FoodsController < ApplicationController
   before_action :authenticate_user!

   def indexs
     @foods = current_user.foods
   end

   def new
     @food = Food.new
   end

   def create
     @food = current_user.foods.build(food_params)

     if @food.save
       redirect_to foods_url, notice: 'Food was successfully created.'
     else
       render :new
     end
   end

   def destroy
     @food = current_user.foods.find(params[:id])
     @food.destroy
     redirect_to foods_url, notice: 'Food was successfully deleted.'
   end

   private

   def food_params
     params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
   end
 end
