class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with:  :null_session
  after_filter :store_location
  
  def after_sign_out_path_for(resources)
    new_user_session_path
  end
  
  def authenticate_user!
   unless user_signed_in?
     flash[:danger] = "You must login first"
     redirect_to new_user_session_path
   end
  end
  
  def store_location
    return unless request.get? 
    if request.fullpath == "/users"
      session[:previous_url] = users_path
    end
  end
  
  def after_sign_in_path_for(resources)
     session[:previous_url] || root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
  end
end
