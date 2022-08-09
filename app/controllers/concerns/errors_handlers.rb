module ErrorsHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from Admin::LoginErrors::NotAnAdmin, with: :not_an_admin
  end

  private

  def not_an_admin
    render json: { message: "You don't have enough privileges" }, status: :forbidden
  end
end
