class CreateMaintenanceActions < ActiveRecord::Migration
  def change
    create_table :maintenance_actions do |t|
      t.date :date
      t.references :tool, index: true
      t.references :person, index: true
      t.references :maintenance_type, index: true

      t.timestamps
    end
  end
end
