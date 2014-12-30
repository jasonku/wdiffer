class App.Views.HomeView extends App.View

  events:
    "submit form": "onFormSubmit"
    "click .js-hide-expected": "onHideExpectedClick"
    "click .js-demo": "onDemoClick"

  onDemoClick: (e) =>
    e.preventDefault()

    # TODO find a better place to put these constants
    expected = $('.js-expected')
    expected.val("All Scripture is inspired by God and profitable for teaching, for reproof, for correction, for training in righteousness; so that the man of God may be adequate, equipped for every good work.")

    actual = $('.js-actual')
    actual.val("Some of Scripture is inspired by God for teaching, for reproof, for correction, for training; so that the man of God may be adequate and equipped for every good work.")

    $('.js-ignore-case').prop('checked', false)

    $('form').submit()

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
