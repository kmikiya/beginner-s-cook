class Customer::RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @material = @recipe.materials.build
    @material_detail = @material.build_material_detail
    @explanation = @recipe.explanations.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
        if @recipe.save
          redirect_to root_path
        else
          render 'new'
        end
  end

  def show
    @recipe = Recipe.find(params[:id])
    impressionist(@recipe, nil, unique: [:ip_address])
    @explanations = @recipe.explanations
    @materials = @recipe.materials
    @calorie = MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:calorie).sum
    @sugar = MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:sugar).sum
    @protein = MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:protein).sum
    @lipids = MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:lipids).sum
    @dietary_fiber = MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:dietary_fiber).sum
    @salt = MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:salt).sum
    #平均点
    @reports = @recipe.reports
    if @reports.exists?
      @average = @reports.average(:evaluation).round(1)
    end
    @list = List.new
    @comment = Comment.new
    #@people = @recipe.materials.people
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

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def search
    @category = Category.find_by(id: params[:id])

    if @category.ancestry == nil
      category = Category.find_by(id: params[:id]).indirect_ids
      if category.empty?
        @recipes = Recipe.where(category_id: @category.id).order(created_at: :desc)
      else
        @recipes = []
        find_item(category)
      end

    elsif @category.ancestry.include?("/")
      @recipes = Recipe.where(category_id: params[:id]).order(created_at: :desc)

    else
      category = Category.find_by(id: params[:id]).child_ids
      @recipes = []
      find_item(category)
    end
  end

  def find_item(category)
    category.each do |id|
      recipe_array = Recipe.where(category_id: id).order(created_at: :desc)
      if recipe_array.present?
        recipe_array.each do |recipe|
          if recipe.present?
            @recipes.push(recipe)
          end
        end
      end
    end
  end

  private

  def recipe_params
     params.require(:recipe).permit(:image, :title, :time, :comment, :customer_id, :people, explanations_attributes: [:id, :explanation, :process_image],
     materials_attributes: [:id, :amount, :material_detail_id])
  end

end
