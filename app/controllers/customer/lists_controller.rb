class Customer::ListsController < ApplicationController

  def index
    @lists = current_customer.lists
    
  end

  def create
      list = List.new(list_params)
      list.save
      redirect_to request.referer
  end

  private

  def list_params
    params.require(:list).permit(:customer_id, :material_detail_id)
  end

end
