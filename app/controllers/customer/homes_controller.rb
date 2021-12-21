class Customer::HomesController < ApplicationController
  before_action :set_parents

    def top
      @recipes = Recipe.page(params[:page]).per(4).order("created_at desc")
      #evaluation_avgここで定義
      @reports = Report.group(:recipe_id).select("recipe_id, AVG(evaluation) AS evaluation_avg").order("evaluation_avg desc").page(params[:page]).per(4)
      # binding.irb
      recipes = Recipe.all
      @recipe_pvs = recipes.order(impressions_count: 'DESC').page(params[:page]).per(4)

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

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def evaluation
    @reports = Report.group(:recipe_id).select("recipe_id, AVG(evaluation) AS evaluation_avg").order("evaluation_avg desc").page(params[:page]).per(6)
  end

  def view
    recipes = Recipe.all
   @recipe_pvs = recipes.order(impressions_count: 'DESC').page(params[:page]).per(6)
  end

  def create_at
    @recipes = Recipe.page(params[:page]).per(6).order("created_at desc")
  end

end
