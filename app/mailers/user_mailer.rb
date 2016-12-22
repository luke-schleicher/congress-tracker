class UserMailer < ApplicationMailer

  default from: "welcome@congresstracker.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to CongressTracker")
  end



  def weekly_email(user)
    @user = user
    mail(to: @user.email, subject: "Here's what your lawmakers have been up to this week")
  end



end
