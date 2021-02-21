class AddFullNameToCompensations < ActiveRecord::Migration[6.0]
  def change
    add_column :compensations, :full_name, :string
  end
end
