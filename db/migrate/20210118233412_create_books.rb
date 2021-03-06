class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false

      t.timestamps
    end
  add_index :books, :title, unique: false
  end
end
