class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.belongs_to :book, null: true, foreign_key: true
      t.string :title, null: false
      t.text :content

      t.timestamps
    end
  end
end
