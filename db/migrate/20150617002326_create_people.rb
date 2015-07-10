class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.integer :graduation_year
      t.string :barcode
      t.string :emergency_contact_name
      t.string :emergency_contact_number
      t.boolean :archived
      t.boolean :is_admin
      t.boolean :is_student_admin

      t.timestamps
    end
  end
end
