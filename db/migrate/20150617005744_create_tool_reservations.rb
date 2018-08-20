class CreateToolReservations < ActiveRecord::Migration
  def change
    create_table :tool_reservations do |t|
      t.references :person, index: true
      t.references :tool, index: true
      t.datetime :reservation_beginning
      t.datetime :reservation_ending

      t.timestamps
    end
  end
end
