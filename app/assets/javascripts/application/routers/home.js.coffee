class App.Routers.Home extends App.Router

  routes:
    "" : "index"

  index: ->
    view = new App.Views.HomeView
      el: "#home"
    view.render()
