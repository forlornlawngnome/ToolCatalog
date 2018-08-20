class AddAlternatingToHours < ActiveRecord::Migration
  def change
    add_column :hours, :alternating, :boolean
    add_column :hours, :alt_start, :date
  end
end
