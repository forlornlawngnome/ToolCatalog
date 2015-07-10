class CreateDocumentationLinks < ActiveRecord::Migration
  def change
    create_table :documentation_links do |t|
      t.string :name
      t.string :link
      t.references :course, index: true
      t.boolean :active

      t.timestamps
    end
  end
end
