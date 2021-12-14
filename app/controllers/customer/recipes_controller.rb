class Customer::RecipesController < ApplicationController
  before_action :set_parents


  def top
    @recipes = Recipe.page(params[:page]).per(3).order("created_at desc")
    #evaluation_avgここで定義
    @reports = Report.group(:recipe_id).select("recipe_id, AVG(evaluation) AS evaluation_avg").order("evaluation_avg desc").page(params[:page]).per(3)
    # binding.irb
    recipes = Recipe.all
    @recipe_pvs = recipes.order(impressions_count: 'DESC').page(params[:page]).per(3)

    respond_to do |format|
      format.html
      format.json do
        if params[:parent_id]
          @childrens = Category.find(params[:parent_id]).children
        elsif params[:children_id]
          @grandChilds = Category.find(params[:children_id]).children
        elsif params[:gcchildren_id]
          @parents = Category.where(id: params[:gcchildren_id])
        end
      end
  end

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
    if @recipe.save!
    redirect_to root_path
    end
  end

  def confirm
    @recipe = Recipe.new(recipe_params)
  end

  def show
    @recipe = Recipe.find(params[:id])
    impressionist(@recipe, nil, unique: [:ip_address])
    @explanations = @recipe.explanations
    @materials = @recipe.material_details
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
     params.require(:recipe).permit(:image, :title, :time, :comment, :customer_id, explanations_attributes: [:id, :explanation, :process_image],
     material_attributes: [:id], material_details_attributes: [:id, :name, :amount] )
  end

end
