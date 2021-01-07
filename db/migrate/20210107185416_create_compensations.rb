class CreateCompensations < ActiveRecord::Migration[6.0]
  def change
    create_table :compensations do |t|
      t.float :GFC_operational_fee_in_EUR
      t.float :total_payable_price_in_EUR
      t.boolean :toc_checked
      t.boolean :newsletter_checked

      t.timestamps
    end
  end
end
