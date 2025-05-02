module Api
  class LibraryController < ApplicationController
    def next_book
      ids = params[:books] || []
      idx = params[:index].to_i
      books = Book.where(id: ids).order(Arel.sql("array_position(ARRAY[#{ids.join(',')}]::int[], id)")).to_a

      new_idx = idx < books.size - 1 ? idx + 1 : 0
      book = books[new_idx]

      render json: {
        index: new_idx,
        id:    book.id,
        book_name:  book.book_name,
        author: book.author,
        image:  book.image,
        count: book.count
      }
    end

    def prev_book
      ids = params[:books] || []
      idx = params[:index].to_i
      books = Book.where(id: ids).order(Arel.sql("array_position(ARRAY[#{ids.join(',')}]::int[], id)")).to_a

      new_idx = idx > 0 ? idx - 1 : books.size - 1
      book = books[new_idx]

      render json: {
        index: new_idx,
        id:    book.id,
        book_name:  book.book_name,
        author: book.author,
        image:  book.image,
        count: book.count
      }
    end
  end
end
