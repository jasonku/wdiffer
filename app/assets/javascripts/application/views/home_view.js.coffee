class App.Views.HomeView extends App.View

  events:
    "submit form#new_diff": "onFormSubmit"
    "click .js-hide-expected": "onHideExpectedClick"

  onFormSubmit: (e) =>
    e.preventDefault()

    form = e.target

    $('.js-results').html('')
    $('.js-loader').show()

    $.ajax
      url: form.action
      type: form.method
      dataType: 'json'
      data: $(form).serialize()
      success: @onDiffSuccess

  onDiffSuccess: (data) =>
    $('.js-loader').hide()

    results = data.results

    $('.js-results').html(results)

  onHideExpectedClick: (e) =>
    e.preventDefault()

    expected = $('.js-expected')
    link = $(e.target)

    linkText =
      if expected.is(':visible')
        "(show)"
      else
        "(hide)"

    link.html(linkText)

    expected.toggle('800')
