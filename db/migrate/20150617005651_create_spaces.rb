class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :name
      t.integer :max_people
      t.boolean :reservable
      t.integer :max_reservable_time

      t.timestamps
    end
  end
end
