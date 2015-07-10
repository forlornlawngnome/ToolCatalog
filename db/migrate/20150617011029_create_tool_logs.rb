class CreateToolLogs < ActiveRecord::Migration
  def change
    create_table :tool_logs do |t|
      t.references :tool, index: true
      t.references :person, index: true
      t.datetime :time_in
      t.datetime :time_out
      t.integer :duration
      t.references :tool_reservation, index: true

      t.timestamps
    end
  end
end
