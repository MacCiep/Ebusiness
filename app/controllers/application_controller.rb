class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json

  def authenticate_admin!
    super
    raise Api::LoginErrors::AccountBlocked if current_user.blocked
  end

  def configure_permitted_parameters
    added_attrs = [:name, :lastname, :username, :email, :encrypted_password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
