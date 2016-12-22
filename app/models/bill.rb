class Bill < ApplicationRecord

  self.primary_key = 'bill_id'

  has_many :votes
  has_many :legislators, through: :votes

  def to_param
    bill_id.parameterize
  end

end
