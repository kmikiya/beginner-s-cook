class Customer::ListsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @lists = current_customer.lists

  end

  def create
      list = List.new(list_params)
      list.save
      redirect_to request.referer
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to request.referer
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to request.referer
  end

  def destroy_all
    products = current_customer.lists
    products.destroy_all
    redirect_to request.referer
  end

  private

  def list_params
    params.require(:list).permit(:customer_id, :material_detail_id, :memo)
  end

end
