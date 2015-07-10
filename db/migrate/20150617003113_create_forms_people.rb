class CreateFormsPeople < ActiveRecord::Migration
  def change
    create_table :forms_people do |t|
      t.references :person, index: true
      t.references :form, index: true

      t.timestamps
    end
  end
end
