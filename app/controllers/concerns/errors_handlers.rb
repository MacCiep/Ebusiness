module ErrorsHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from Admin::LoginErrors::NotAnAdmin, with: :not_an_admin
    rescue_from Api::LoginErrors::AccountBlocked, with: :account_blocked
  end

  private

  def not_an_admin
    render json: { message: "You don't have enough privileges" }, status: :forbidden
  end

  def account_blocked
    render json: { message: "Your account has been blocked, contact us" }, status: :forbidden
  end
end
