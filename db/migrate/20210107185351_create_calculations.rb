class CreateCalculations < ActiveRecord::Migration[6.0]
  def change
    create_table :calculations do |t|
      t.string :fuel_type
      t.integer :weight_in_kg
      t.float :CO2_in_kg
      t.float :SAF_in_kg
      t.float :SAF_price_in_EUR
      t.references :compensation, foreign_key: true

      t.timestamps
    end
  end
end
