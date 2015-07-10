class CreateMaintananceActions < ActiveRecord::Migration
  def change
    create_table :maintanance_actions do |t|
      t.date :date
      t.references :tool, index: true
      t.references :person, index: true
      t.references :maintanance_type, index: true

      t.timestamps
    end
  end
end
