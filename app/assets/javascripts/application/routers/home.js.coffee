class App.Routers.Home extends App.Router

  routes:
    "" : "index"
    "books" : "books"

  index: ->
    view = new App.Views.HomeView
      el: "#home"
    view.render()

  books: ->
    view = new App.Views.BooksView
      el: "#home"
    view.render()
