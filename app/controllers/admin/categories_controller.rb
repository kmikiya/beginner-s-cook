class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.where(ancestry: nil)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    category_parent = Category.find(params[:category][:id])
    category_children = category_parent.children.create(name: params[:category][:child_name])
    category_children.children.create(name: params[:category][:grandchild_name]) unless params[:category][:grandchild_name].blank?
    redirect_to admin_categories
  end

  # def parents
  #   @parents = Category.where(ancestry: nil)
  # end

  # def category_children
  #   @category_children = Category.find("#{params[:parent_id]}").children
  # end

  # def category_grandchildren
  #   @category_grandchildren = Category.find("#{params[:child_id]}").children
  # end

  private

  def category_params
    params.require(:category).permit(:id, :name, :ancestr, :child_name, :grandchild_name)
  end


end
