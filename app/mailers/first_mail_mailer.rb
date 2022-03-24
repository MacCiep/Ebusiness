class FirstMailMailer < ApplicationMailer
  def first_mail(user)
    @user = user
    mail(
      to: user.email,
      subject: "Hi, we are very happy that you joined our community!"
    )
  end
end
