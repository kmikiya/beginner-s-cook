class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to request.referer
  end
end
