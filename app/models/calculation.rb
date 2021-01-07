class Calculation < ApplicationRecord
  belongs_to :compensation, optional: true

  #validates :fuel_type, presence: true
  #validates :fuel_type, inclusion: { in: ["Jet A-1", "Jet B", "AvGas"],message: "is not a valid fuel_type" }

  #validates :weight_in_kg, presence: true
  #validates :weight_in_kg, numericality: true
end
