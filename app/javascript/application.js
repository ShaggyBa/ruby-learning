// app/javascript/application.js
import "@hotwired/turbo-rails"
import "controllers"          // этот импорт подхватит index.js из controllers
import "jquery"
import "@rails/ujs"

// ваш лог
console.log("Working!")
Rails.start()