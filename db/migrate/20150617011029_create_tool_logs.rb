class CreateToolLogs < ActiveRecord::Migration
  def change
    create_table :tool_logs do |t|
      t.references :tool, index: true
      t.references :person, index: true
      t.datetime :time_beginning
      t.datetime :time_ending
      t.integer :duration
      t.references :tool_reservation, index: true

      t.timestamps
    end
  end
end
