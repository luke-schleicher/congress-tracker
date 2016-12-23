class UserMailer < ApplicationMailer

  helper MailerHelper

  default from: "welcome@congresstracker.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to CongressTracker")
  end

  def weekly_email(user)
    @user = user
    mail(to: @user.email, subject: "Your weekly lawmaker summary")
  end



end
