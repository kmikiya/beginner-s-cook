class Customer::RecipesController < ApplicationController
  def top
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @explanation = @recipe.explanations.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
    redirect_to root_path
    end
  end

  def confirm
    @recipe = Recipe.new(recipe_params)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @explanations = @recipe.explanations
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to root_path
  end


  private

  def recipe_params
     params.require(:recipe).permit(:image, :title, :time, :comment, :customer_id, explanations_attributes: [:id, :explanation, :process_image])
  end


  #def explanation_params
   #  params.require(:explanation).permit(:recipe_id, :explanation, :image )
  #end
end
