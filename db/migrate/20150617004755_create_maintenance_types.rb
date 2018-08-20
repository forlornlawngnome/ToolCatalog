class CreateMaintenanceTypes < ActiveRecord::Migration
  def change
    create_table :maintenance_types do |t|
      t.string :name
      t.references :category, index: true
      t.integer :required_days_between_maintenance
      t.text :instructions

      t.timestamps
    end
  end
end
