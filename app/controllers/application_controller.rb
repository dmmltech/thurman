class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :store_current_location, :unless => :devise_controller?
  before_action :set_pages

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :avatar, :password,])
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_out_path_for(*)
    request.referrer || root_path
  end

  def set_pages
    @menupages = Page.where.not(parent_id: nil).where(menu: true).where(status: 'Published').where(visibility: 'Public').order(order: :asc).group_by{ |r| r.parent}
  end
  
end
