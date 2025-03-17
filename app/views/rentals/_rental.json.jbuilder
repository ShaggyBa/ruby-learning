json.extract! rental, :id, :book_id, :user_id, :rent_date, :collection_period, :librarian_id, :created_at, :updated_at
json.url rental_url(rental, format: :json)
