class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.references :category, index: true
      t.text :additional_info
      t.integer :recertification

      t.timestamps
    end
  end
end
