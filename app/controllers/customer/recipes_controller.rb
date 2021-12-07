class Customer::RecipesController < ApplicationController
  def top
    @recipes = Recipe.all
    #evaluation_avgここで定義
    @reports = Report.group(:recipe_id).select("recipe_id, AVG(evaluation) AS evaluation_avg").order("evaluation_avg desc")
    # binding.irb
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @explanation = @recipe.explanations.build
    @material_detail = @recipe.material_details.build
    @material = @material_detail.materials.build
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
    @materials = @recipe.material_details
    #平均点
    @reports = @recipe.reports
    if @reports.exists?
      @average = @reports.average(:evaluation).round(1)
    end

    @comment = Comment.new
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
     params.require(:recipe).permit(:image, :title, :time, :comment, :customer_id, explanations_attributes: [:id, :explanation, :process_image],
     material_attributes: [:id], material_details_attributes: [:id, :name, :amount] )
  end

end
