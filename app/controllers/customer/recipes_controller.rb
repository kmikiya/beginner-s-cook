class Customer::RecipesController < ApplicationController
  before_action :set_parents

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @material = @recipe.materials.build
    @material_detail = @material.build_material_detail
    @explanation = @recipe.explanations.build({})
    #byebug
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to root_path
    else
      # @explanation =  Recipe.new(recipe_params).explanations.build
      render 'new'
      #byebug
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    impressionist(@recipe, nil, unique: [:ip_address])
    @explanations = @recipe.explanations
    @materials = @recipe.materials
    @roughs = @recipe.materials.map{|m| m.rough/100}#材料を1グラムあたりに変換
    array = [*0.. @roughs.count-1]#材料の数を数え上げてる
    @calorie = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:calorie)[m]}.sum.round(1)#33行目で数え上げた個数分だけ足し合わせてる
    @sugar = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:sugar)[m]}.sum.round(1)
    @protein = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:protein)[m]}.sum.round(1)
    @lipids = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:lipids)[m]}.sum.round(1)
    @dietary_fiber = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:dietary_fiber)[m]}.sum.round(1)
    #byebug
    @salt = array.map{|m| @roughs[m]*MaterialDetail.where(id: @materials.pluck(:material_detail_id)).pluck(:salt)[m]}.sum.round(1)
    #平均点
    @reports = @recipe.reports
    if @reports.exists?
      @average = @reports.average(:evaluation).round(1)
    end
    @list = List.new
    @comment = Comment.new
    @category_id = @recipe.category_id
    @category_grandchild = Category.find(@category_id)#レシピが持ってる一番下のカテゴリ
    @category_child = @category_grandchild.parent
    #@category_parent = @category_grandchild.parent.parent

  end

  def edit
    @recipe = Recipe.find(params[:id])
    redirect_to new_customer_session_path unless customer_signed_in?
    if customer_signed_in?
      redirect_to root_path unless current_customer == @recipe.customer
    end

  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
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
    @category = Category.find(params[:category_id])#選択中のカテゴリ
      #if @category.indirects.children == nil && @category.parent == nil
        #自分と子供と孫を表示
      #elsif @category.children.children == nil && @category.parent.parent == nil
        #@recipes = Recipe.where(category_id: @category.indirect_ids)#自分と孫を表示
      #elsif @category.children == nil　&& @category.parent.parent.parent == nil #自分が孫の時
        @recipes = @category.recipes.page(params[:page]).per(6).order("created_at desc")
      #end
  end

  def find_item(category)
    category.each do |id|#選ばれたカテゴリの孫または子供のidをひとつずつ取り出す
      recipe_array = Recipe.where(category_id: id).order(created_at: :desc)#レシピの中で孫または子供のidを持っているレコードを取り出す。
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
