module Admin
  class UsersController < AdminController
    before_action :set_user, only: [:block, :unblock, :make_admin]

    def block
      if @user.update(blocked: true)
        render status: :no_content
      else
        render json: { error: @user.errors.full_messages }, status: :bad_request
      end
    end

    def unblock
      if @user.update(blocked: false)
        render status: :no_content
      else
        render json: { error: @user.errors.full_messages }, status: :bad_request
      end
    end

    def make_admin
      if @user.update(user_type: :admin)
        render status: :no_content
      else
        render json: { error: @user.errors.full_messages }, status: :bad_request
      end
    end

    def index
      render json: User.all
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end