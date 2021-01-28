class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception
   before_action :configure_device_params, if: :devise_controller?
   
   def configure_device_params
     devise_parameter_sanitizer.permit(:sign_up) do |user|
       user.permit(:email, :name, :password, :password_confirmation)
     end
     devise_parameter_sanitizer.permit(:account_update) do |user|
       user.permit(:email, :name, :password, :password_confirmation, :current_password)

     end
   end
end
