class ApplicationController < ActionController::Base
    before_action :authenticate_user!, unless: :devise_controller?
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
    end

    def after_sign_in_path_for(resource)
      dashboard_index_path
    end

    def after_sign_out_path_for(resource_or_scope)
      root_path
    end
end
