class LibraryController < ApplicationController
  def index
    @books = Book.all

    @popular_books = Book.most_rented(5)

    @guest = User.find_by(email: 'guest@example.com')
    @my_rentals = []

    @random_books = Book.order("RANDOM()").limit(10)
  end

  def choose_category
    @categories = Book.distinct.pluck(:category)
    render partial: "categories_list", locals: { categories: @categories }
  end

  def display_book
    category = params[:category]
    book = Book.where(category: category).first

    render partial: "book_display", locals: { category: category, book: book }
  end

  def search_books
    query = params[:query]
    @results = Book.where("book_name ILIKE ?", "%#{query}%")
    render partial: "search_results", locals: { results: @results }
  end

  def users_rentals
    @users = User.where(role: "reader")
    if params[:user_id].present?
      @user    = User.find(params[:user_id])
      @rentals = @user.rentals.includes(:book)
    end
  end

  def all_books
    sort_by = params[:sort_by]

    @books = case sort_by
             when "alphabetical"
               Book.order(:book_name)
             when "count"
               Book.order(count: :desc)
             else
               Book.all
             end
  end

end




