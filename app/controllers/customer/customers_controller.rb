class Customer::CustomersController < ApplicationController


  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes.page(params[:page]).per(4)
    @recipeds = @customer.recipes.page(params[:page]).per(8)
    @reports = Report.where(customer_id: @customer.id).page(params[:page]).per(8)
  end

  def edit
    @customer = Customer.find(params[:id])
    redirect_to edit_customer_path(current_customer.id) unless current_customer.id == @customer.id
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to my_page_path(@customer)
  end

  def my_recipe
    @customer = Customer.find(params[:customer_id])
    @recipes = @customer.recipes.page(params[:page]).order("created_at desc").per(6)
  end

  def my_report
    @customer = Customer.find(params[:customer_id])
    @reports = @customer.reports.page(params[:page]).per(6).order("created_at desc")
  end

  def receive_report
    @customer = Customer.find(params[:customer_id])
    #byebug
    @recipeds = @customer.recipes.page(params[:page]).per(8).order("created_at desc")
    #@recipes = current_customer.recipes.map{|m| m.reports}.map{|m| m}
  end

  private

  def customer_params
    params.require(:customer).permit(:profile_image, :bg_image, :name, :profile)
  end
end
