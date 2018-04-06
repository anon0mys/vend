class CreateMachinesnacks < ActiveRecord::Migration[5.1]
  def change
    create_table :machinesnacks do |t|
      t.references :machine
      t.references :snack

      t.timestamps
    end
  end
end
