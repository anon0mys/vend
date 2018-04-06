class Machine < ApplicationRecord
  belongs_to :owner
  has_many :machinesnacks
  has_many :snacks, through: :machinesnacks
end
