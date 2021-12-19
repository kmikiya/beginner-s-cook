class Customer::ReportsController < ApplicationController
  #before_action :authenticate_customer!,except: [:new]

  def new
    @report = Report.new
    @recipe = Recipe.find(params[:recipe_id])
    redirect_to new_customer_session_path unless customer_signed_in?
  end

  def index
    @recipe = Recipe.find(params[:recipe_id])
    @reports = @recipe.reports
    #@reports = Report.where(recipe_id: @recipe.id)
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @report = Report.new(report_params)
    if @report.save
      redirect_to recipe_reports_path(@recipe)
    else
      render 'new'
    end
  end

  def destroy
     @report = Report.find(params[:id])
     @report.destroy
     redirect_to request.referer
  end

  private

  def report_params
    params.require(:report).permit(:image, :impression, :evaluation, :customer_id, :recipe_id)
  end

end
