require 'rails_helper'

RSpec.describe Book, type: :model do
  it "is valid with valid attributes" do
    book = Book.new(book_name: "Test", author: "Author", count: 1)
    expect(book).to be_valid
  end
end