class User < ApplicationRecord

  validates :email, uniqueness: true

  has_many :legislator_users
  has_many :legislators, through: :legislator_users

  def assign_legislators(rep_ids)
    rep_ids.each do |id|
      self.legislators << Legislator.find(id)
    end
  end

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
