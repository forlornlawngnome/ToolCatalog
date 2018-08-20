class CreateCoursesPeople < ActiveRecord::Migration
  def change
    create_table :courses_people do |t|
      t.references :course, index: true
      t.references :person, index: true
      t.date :date_requested
      t.string :approver
      t.boolean :approved
      t.date :approval_date

      t.timestamps
    end
  end
end
