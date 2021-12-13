class Customer::FavoritesController < ApplicationController

  def create
    recipe = Recipe.find(params[:recipe_id])
    favorite = Favorite.new(customer_id: current_customer.id, recipe_id: recipe.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    favorite = Favorite.find_by(customer_id: current_customer.id, recipe_id: recipe.id)
    favorite.destroy
    redirect_to request.referer
  end

  def index
    @favorites = current_customer.favorites
  end

end
