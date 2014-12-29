class App.Views.HomeView extends App.View

  events:
    "submit form#new_diff": "onFormSubmit"

  onFormSubmit: (e) =>
    e.preventDefault()

    form = e.target

    console.log("Submitting...")

    $.ajax
      url: form.action
      type: form.method
      dataType: "json"
      data: $(form).serialize()
      success: @onDiffSuccess

  onDiffSuccess: (data) =>
    results = data.results
    console.log("SUCCESS: #{results}")

