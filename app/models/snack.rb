class Snack < ApplicationRecord
  has_many :machinesnacks
  has_many :machines, through: :machinesnacks
end
