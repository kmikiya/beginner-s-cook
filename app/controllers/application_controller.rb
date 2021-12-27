class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  before_action :set_parents

  def set_search
    @search = Recipe.ransack(params[:q])

    @search_recipes = @search.result(distinct: true).order(created_at: "DESC")
  end

  #ログイン後のリンク先設定
  def after_sign_in_path_for(resource)
    case resource
      when Customer
        my_page_path(current_customer)
      when Admin
        admin_path
    end
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
