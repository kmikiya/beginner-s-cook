class Customer::FavoritesController < ApplicationController
  before_action :authenticate_customer!

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
    @favorites = current_customer.favorites.order(created_at: 'DESC').page(params[:page]).per(6)
  end

end
