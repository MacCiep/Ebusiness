class UserNotifierMailer < ApplicationMailer
  def user_notification
    @user = params[:user]

    mail(
      to: params[:recipient].email,
      subject: @user.issuer_trading_symbol
    )
  end
end
