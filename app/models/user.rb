class User < ApplicationRecord

  validates :email, uniqueness: true

  def self.welcome_email(id)
    UserMailer.welcome(find(id)).deliver
  end

  def self.weekly_email(id = nil)
    if id.nil?
      User.all.each do |u|
        UserMailer.delay.weekly_email(u).deliver
      end
    else
      UserMailer.weekly_email(find(id)).deliver
    end
  end

end
