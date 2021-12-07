class Admin::MaterialDetailsController < ApplicationController

  def index
    @materials = MaterialDetail.all
  end

  def new
    @material = MaterialDetail.new
  end

  def create
    @material = MaterialDetail.new(material_detail_params)
    @material.save
    redirect_to admin_material_details_path
  end

  def edit
    @material = MaterialDetail.find(params[:id])
  end

  def update
    @material = MaterialDetail.find(params[:id])
    @material.update(material_detail_params)
    redirect_to admin_material_details_path
  end

  def destroy
    @material = MaterialDetail.find(params[:id])
    @material.destroy
    redirect_to admin_material_details_path
  end


  private

  def material_detail_params
    params.require(:material_detail).permit(:name, :calorie, :sugar, :dietary_fiber, :protein, :lipids, :salt, :amount)
  end

end
