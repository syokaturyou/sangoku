class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
      if resource.is_a?(Admin)
         manager_posts_path(resource)
      else resource.is_a?(Member)
         public_posts_path(resource)
      end
    end

   def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    elsif resource_or_scope == :member
        root_path(resource)
    end
   end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email] )
    end

end
