class App.Views.HomeView extends App.View
  spaceKeyCode: 32

  events:
    "submit .js-diff form": "onDiffSubmit"
    "click .js-toggle-benchmark": "onToggleBenchmarkClick"
    "click .js-hide-results": "onHideResultsClick"
    "click .js-use-passage": "onUsePassageClick"
    "click .js-demo": "onDemoClick"
    "keyup .js-actual": "onActualKeyup"
    "submit .js-passage form": "onPassageSubmit"

  onHideResultsClick: (e) =>
    e.preventDefault()

    $('.js-results-container').hide()

  onActualKeyup: (e) =>
    if (@checkLive() and e.keyCode is @spaceKeyCode)
      benchmark = $('.js-benchmark').val()
      actual = $('.js-actual').val().trim()

      actualWordCount = actual.split(' ').length
      partialBenchmark = benchmark.split(' ')[0..actualWordCount-1].join(' ').trim()
      @diff(partialBenchmark, actual)

  onPassageSubmit: (e) =>
    e.preventDefault()

    form = e.target

    @showLoader()

    # TODO move this into a backbone model.
    $.ajax
      url: form.action
      type: form.method
      dataType: 'json'
      data: $(form).serialize()
      success: @onPassageSuccess
      error: @onPassageError

  showPassageError: =>
    $('.js-passage-error').show()

  hidePassageError: =>
    $('.js-passage-error').hide()

  onPassageError: (xhr, textStatus, errorThrown) =>
    @hideLoader()
    @showPassageError()

  onPassageSuccess: (data) =>
    @hideLoader()
    @hidePassageError()

    passagesContent =
      _.map data, (content, reference) =>
        content
    passagesContent = passagesContent.join(' ')

    contentForBenchmark = $('<div/>').html(passagesContent).text()
    $('.js-benchmark').val(contentForBenchmark).text()

  onDemoClick: (e) =>
    e.preventDefault()

    # TODO find a better place to put these constants
    benchmark = $('.js-benchmark')
    benchmark.val("All Scripture is inspired by God and profitable for teaching, for reproof, for correction, for training in righteousness; so that the man of God may be adequate, equipped for every good work.")

    actual = $('.js-actual')
    actual.val("Some of Scripture is inspired by God for teaching, for reproof, for correction, for training; so that the man of God may be adequate and equipped for every good work.")

    $('.js-ignore-case').prop('checked', false)

    $('.js-diff form').submit()

  onDiffSubmit: (e) =>
    e.preventDefault()

    form = e.target

    benchmark = $('.js-benchmark').val()
    actual = $('.js-actual').val()

    @diff(benchmark, actual)

  diff: (benchmark, actual) =>
    if benchmark || actual
      unless @checkLive()
        @showResults('')
        @showLoader()

      if @ignoreCase()
        benchmark = benchmark.toLowerCase()
        actual = actual.toLowerCase()

      benchmark = @escapeHTML(benchmark)
      actual = @escapeHTML(actual)

      JsDiff.diffWords(actual, benchmark, @onDiffSuccess)
    else
      @showResults("Please enter some text to compare.")

  showLoader: =>
    $('.js-loader').show()

  hideLoader: =>
    $('.js-loader').hide()

  checkLive: =>
    $('.js-check-live').is(':checked')

  ignoreCase: =>
    $('.js-ignore-case').is(':checked')

  onDiffSuccess: (dummy, diffs) =>
    @hideLoader()

    resultsContent = ""

    diffs.forEach (diff) =>
      result =
        if diff.added
          "<ins>#{diff.value}</ins>"
        else if diff.removed
          "<del>#{diff.value}</del>"
        else
          diff.value

      resultsContent = resultsContent + result

    @showResults(resultsContent)

  showResults: (content) =>
    resultsContainer = $('.js-results-container')
    results = $('.js-results')
    results.html(content)
    resultsContainer.show()

  onToggleBenchmarkClick: (e) =>
    e.preventDefault()

    benchmark = $('.js-benchmark')
    link = $(e.target)

    linkText =
      if benchmark.is(':visible')
        "(show)"
      else
        "(hide)"

    link.html(linkText)

    benchmark.toggle('800')

  onUsePassageClick: (e) =>
    e.preventDefault()

    passageLookup = $('.js-passage')

    passageLookup.toggle('800')

    $('.js-passage-query').focus()

  escapeHTML: (string) =>
    string = string.replace(/&/g, '&amp;')
    string = string.replace(/</g, '&lt;')
    string = string.replace(/>/g, '&gt;')
    string = string.replace(/"/g, '&quot;')
    string
