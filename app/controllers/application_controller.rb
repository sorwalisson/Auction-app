class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?
  
  protected

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :zip, :cpf])
  end

  def authenticate_user_admin
    redirect_to root_path unless current_user.admin?
  end
end
