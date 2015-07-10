class CreateSpaceReservations < ActiveRecord::Migration
  def change
    create_table :space_reservations do |t|
      t.references :person, index: true
      t.references :space, index: true
      t.datetime :reservation_beginning
      t.datetime :reservation_ending
      t.integer :number_of_people

      t.timestamps
    end
  end
end
