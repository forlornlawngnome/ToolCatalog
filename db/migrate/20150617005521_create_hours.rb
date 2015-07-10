class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.time :time_open
      t.time :time_close
      t.references :person, index: true
      t.integer :day_of_week

      t.timestamps
    end
  end
end
