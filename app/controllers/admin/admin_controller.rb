module Admin
  class AdminController < ApplicationController
    include ErrorsHandlers
    before_action :authenticate_user!
    after_action :authenticate_admin!, only: [:authenticate_user!]

    def authenticate_admin!
      raise Admin::LoginErrors::NotAnAdmin unless current_user.admin?
    end
  end
end
