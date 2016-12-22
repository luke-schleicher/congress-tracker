class User < ApplicationRecord

  validates :email, uniqueness: true

  def self.welcome_email(id)
    UserMailer.welcome(find(id)).deliver
  end

  def send_weekly_emails
    User.all.each do |u|
      UserMailer.delay.weekly_email(u).deliver
    end
  end

end
