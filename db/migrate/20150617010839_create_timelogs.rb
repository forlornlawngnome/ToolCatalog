class CreateTimelogs < ActiveRecord::Migration
  def change
    create_table :timelogs do |t|
      t.references :person, index: true
      t.datetime :time_in
      t.datetime :time_out
      t.integer :duration

      t.timestamps
    end
  end
end
