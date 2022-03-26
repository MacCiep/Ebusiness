class WeekendOffersMailer < ApplicationMailer
  def weekly_notifier(user)
    @user = user
    mail(
      to: user.email,
      subject: "Your weekend proposals"
    )
  end
end
