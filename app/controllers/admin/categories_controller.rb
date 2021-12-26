class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    byebug
    category_parent = Category.find(params[:id])
    category_children = category_parent.children.create(params[:child_name])
    category_grandchildren = category_children.children.create(params[:grandchild_name])
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
