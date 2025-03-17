class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :book_name
      t.string :author
      t.string :image
      t.integer :count

      t.timestamps
    end
  end
end
