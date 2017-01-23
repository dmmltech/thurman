class RegistrationsController < Devise::RegistrationsController
 #  invisible_captcha only: [:new]
	# before_filter :configure_permitted_parameters, if: :devise_controller?
  protected

    def account_update_params
      params.require(:user).permit(:name, :email, :password, :avatar)
    end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
 

  def after_sign_up_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def after_inactive_sign_up(resource)
    stored_location_for(resource) || root_path
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def after_update_path_for(resource)
    stored_location_for(resource) || root_path
  end
  
end