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
      redirect_to recipe_path
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
    @category_grandchild = Category.find(@category_id)#レシピが持ってる一番下のカテゴリ
    @category_child = @category_grandchild.parent
    #@category_parent = @category_grandchild.parent.parent

  end

  def edit
    redirect_to new_customer_session_path unless customer_signed_in?
    if customer_signed_in?
      redirect_to root_path unless current_customer == @recipe.customer
    end
  @recipe = Recipe.find(params[:id])
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
        @recipes = Recipe.where(category_id: @category)
      #end
  end

   def search3
    @category = Category.find_by(id: params[:id])#選択されたカテゴリIDのレコードを探す

    if @category.ancestry == nil#ancestryカラムがnilならば
      category = Category.find_by(id: params[:id]).indirect_ids#選ばれたカテゴリの孫idを返す
      if category.empty?#選ばれたカテゴリの孫レコードが存在するなら
        @recipes = Recipe.where(category_id: @category.id).order(created_at: :desc)#レシピが持ってるカテゴリIDの中に選ばれたカテゴリのIDのレコードがあれば取得
      else#選ばれたカテゴリの孫レコードが存在しないなら
        @recipes = []#からの配列を持たせる
        find_item(category)
      end

    #elsif @category.ancestry.include?("/")#ancestryカラムに”/”が含まれていたなら
      #@recipes = Recipe.where(category_id: params[:id]).order(created_at: :desc)#レシピが持ってるカテゴリIDの中に選ばれたカテゴリのIDのレコードがあれば取得
    #else#ancestryカラムが数字のみなら
      #category = Category.find_by(id: params[:id]).child_ids#選ばれたカテゴリの子供idを返す
      #@recipes = []
      #find_item(category)
    end
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
