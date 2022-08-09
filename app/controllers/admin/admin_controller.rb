module Admin
  class AdminController < ApplicationController
    include ErrorsHandlers
    before_action :authenticate_admin!

    def authenticate_admin!
      raise Admin::LoginErrors::NotAnAdmin unless current_user.admin?
    end
  end
end
