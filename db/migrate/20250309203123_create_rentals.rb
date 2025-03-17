class CreateRentals < ActiveRecord::Migration[8.0]
  def change
    create_table :rentals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :rent_date
      t.integer :collection_period

      t.timestamps
    end
  end
end
