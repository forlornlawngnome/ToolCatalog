class CreateTimelogs < ActiveRecord::Migration
  def change
    create_table :timelogs do |t|
      t.references :person, index: true
      t.datetime :time_beginning
      t.datetime :time_ending
      t.integer :duration

      t.timestamps
    end
  end
end
