class App.Views.HomeView extends App.View

  events:
    "click h1": "onH1Click"

  onH1Click: =>
    $("h1").append("HI")
