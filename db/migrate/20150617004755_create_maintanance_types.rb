class CreateMaintananceTypes < ActiveRecord::Migration
  def change
    create_table :maintanance_types do |t|
      t.string :name
      t.references :category, index: true
      t.integer :required_hours_between_maintanance

      t.timestamps
    end
  end
end
