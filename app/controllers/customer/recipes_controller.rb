class Customer::RecipesController < ApplicationController
  before_action :set_parents

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
    @roughs = @recipe.materials.map{|m| m.rough/100}
    array = [*0.. @roughs.count-1]
    @calorie = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:calorie)[m]}.sum.round(1)
    @sugar = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:sugar)[m]}.sum.round(1)
    @protein = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:protein)[m]}.sum.round(1)
    @lipids = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:lipids)[m]}.sum.round(1)
    @dietary_fiber = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:dietary_fiber)[m]}.sum.round(1)
    @salt = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:salt)[m]}.sum.round(1)
    #平均点
    @reports = @recipe.reports
    if @reports.exists?
      @average = @reports.average(:evaluation).round(1)
    end
    @list = List.new
    @comment = Comment.new

    @category_id = @recipe.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
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

  def set_parents
    @parents = Category.where(ancestry: nil)
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
     params.require(:recipe).permit(:image, :title, :time, :comment, :customer_id, :people, :category_id, explanations_attributes: [:id, :explanation, :process_image],
     materials_attributes: [:id, :amount, :rough, :material_detail_id])
  end

end
