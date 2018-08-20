class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name
      t.text :description
      t.text :image
      t.string :serial
      t.string :barcode
      t.date :date_purchased
      t.text :capability
      t.boolean :reservable
      t.integer :max_reservation_time

      t.timestamps
    end
  end
end
