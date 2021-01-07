class AddOffsetapiIdToCalculations < ActiveRecord::Migration[6.0]
  def change
    add_column :calculations, :offsetAPI_id, :string
  end
end
