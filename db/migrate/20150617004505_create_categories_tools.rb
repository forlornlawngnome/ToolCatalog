class CreateCategoriesTools < ActiveRecord::Migration
  def change
    create_table :categories_tools do |t|
      t.references :tool, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
