class Customer::CustomersController < ApplicationController
  

  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes
    @reports = Report.where(customer_id: @customer.id)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to my_page_path(@customer)
  end

  private

  def customer_params
    params.require(:customer).permit(:profile_image, :bg_image, :name, :profile)
  end
end
