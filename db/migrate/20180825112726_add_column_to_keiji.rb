class AddColumnToKeiji < ActiveRecord::Migration[5.1]
  def change
    add_column :keijis, :category_id, :integer
    remove_column :keijis, :category
  end
end
