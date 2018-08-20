class CreateCategoriesCourses < ActiveRecord::Migration
  def change
    create_table :categories_courses do |t|
      t.references :category, index: true
      t.references :course, index: true

      t.timestamps
    end
  end
end
