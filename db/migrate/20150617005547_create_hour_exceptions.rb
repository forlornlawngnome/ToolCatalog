class CreateHourExceptions < ActiveRecord::Migration
  def change
    create_table :hour_exceptions do |t|
      t.datetime :time_beginning
      t.datetime :time_ending
      t.references :person, index: true

      t.timestamps
    end
  end
end
