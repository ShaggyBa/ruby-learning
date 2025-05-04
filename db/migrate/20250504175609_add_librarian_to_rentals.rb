class AddLibrarianToRentals < ActiveRecord::Migration[8.0]
  def change
    add_column :rentals, :librarian_id, :integer
    add_index :rentals, :librarian_id
  end
end
