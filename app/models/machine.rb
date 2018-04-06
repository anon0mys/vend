class Machine < ApplicationRecord
  belongs_to :owner
  has_many :machinesnacks
  has_many :snacks, through: :machinesnacks

  def average_price
    (snacks.average(:price).to_f / 100).round(2)
  end
end
