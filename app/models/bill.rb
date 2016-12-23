class Bill < ApplicationRecord

  self.primary_key = 'bill_id'

  has_many :votes, foreign_key: :bill_id
  has_many :legislators, through: :votes

  belongs_to :sponsor, foreign_key: :sponsor_id, class_name: 'Legislator'

  def to_param
    bill_id.parameterize
  end

end
