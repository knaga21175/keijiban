class CreateKeijis < ActiveRecord::Migration[5.1]
  def change
    create_table :keijis do |t|
      t.date :start
      t.date :end
      t.integer :category
      t.string :title
      t.integer :viewcount

      t.timestamps
    end
  end
end
