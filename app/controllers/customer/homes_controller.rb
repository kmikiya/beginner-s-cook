class Customer::HomesController < ApplicationController
  before_action :set_parents

    def top
      @recipes = Recipe.page(params[:page]).per(3).order("created_at desc")
      #evaluation_avgここで定義
      @reports = Report.group(:recipe_id).select("recipe_id, AVG(evaluation) AS evaluation_avg").order("evaluation_avg desc").page(params[:page]).per(3)
      # binding.irb
      recipes = Recipe.all
      @recipe_pvs = recipes.order(impressions_count: 'DESC').page(params[:page]).per(3)

      @resipe_calories = MaterialDetail.where(id: Material.group(:material_detail_id).select("material_detail_id")).select("calorie AS recipe_calorie").order("recipe_calorie desc")


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

end
