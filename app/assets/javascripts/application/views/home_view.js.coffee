class App.Views.HomeView extends App.View

  events:
    "submit form": "onFormSubmit"
    "click .js-hide-expected": "onHideExpectedClick"

  onFormSubmit: (e) =>
    e.preventDefault()

    form = e.target

    $('.js-results').html('')
    $('.js-loader').show()

    expected = $('.js-expected').val()
    actual = $('.js-actual').val()

    if @ignoreCase()
      expected = expected.toLowerCase()
      actual = actual.toLowerCase()

    expected = @escapeHTML(expected)
    actual = @escapeHTML(actual)

    JsDiff.diffWords(actual, expected, @onDiffSuccess)

  ignoreCase: =>
    $('.js-ignore-case').is(':checked')

  onDiffSuccess: (dummy, diffs) =>
    $('.js-loader').hide()

    results = ""

    diffs.forEach (diff) =>
      result =
        if diff.added
          "<ins>#{diff.value}</ins>"
        else if diff.removed
          "<del>#{diff.value}</del>"
        else
          diff.value

      results = results + result

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

  escapeHTML: (string) =>
    string = string.replace(/&/g, '&amp;')
    string = string.replace(/</g, '&lt;')
    string = string.replace(/>/g, '&gt;')
    string = string.replace(/"/g, '&quot;')
    string
