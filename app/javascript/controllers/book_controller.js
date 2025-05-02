// app/javascript/controllers/book_controller.js
import { Controller } from "@hotwired/stimulus"
import $ from "jquery"
export default class extends Controller {
    static values = {
        index:    Number,
        category: String,
        books:    Array
    }


    connect() {
        this.indexValue    ||= 0
        this.categoryValue ||= this.element.dataset.bookCategory
        this.booksValue    ||= []
    }

    next() {
        // 1) вычисляем новый индекс
        const newIndex = (this.indexValue + 1) % this.booksValue.length
        // 2) сохраняем текущее положение
        this.indexValue = newIndex

        // 3) шлём запрос с этим индексом
        $.getJSON("/api/library/next_book", {
            index: newIndex,
            books: this.booksValue
        }).done((data) => this.update(data))
    }

    prev() {
        // 1) вычисляем новый индекс (циклично)
        const newIndex = (this.indexValue - 1 + this.booksValue.length) % this.booksValue.length
        // 2) сохраняем
        this.indexValue = newIndex

        // 3) запрос
        $.getJSON("/api/library/prev_book", {
            index: newIndex,
            books: this.booksValue
        }).done((data) => this.update(data))
    }

    fetchAndUpdate(newIndex) {
        fetch(`/library/${this.categoryValue === "random" ? "random" : "all"}/next_book`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({
                books: this.booksValue,
                index: newIndex
            })
        })
            .then(response => response.json())
            .then(data => {
                this.indexValue = data.index; // Обновляем index после ответа!

                this.update(data);
            })
    }

    update(book) {
        this.element.querySelector(".book-title").textContent  = book.book_name
        this.element.querySelector(".book-author").textContent = book.author
        this.element.querySelector(".book-count").textContent  = `В наличии: ${book.count}`
        this.element.querySelector(".book-cover img").src     = book.image
    }
}
