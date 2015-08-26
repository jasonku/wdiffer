class App.Views.BooksView extends App.View

  events:
    "submit .js-diff form": "onDiffSubmit"
    "click .js-toggle-benchmark": "onToggleBenchmarkClick"
    "click .js-hide-results": "onHideResultsClick"
    "click .js-demo": "onDemoClick"

  onHideResultsClick: (e) =>
    e.preventDefault()

    $('.js-results-container').hide()

  showPassageError: =>
    $('.js-passage-error').show()

  hidePassageError: =>
    $('.js-passage-error').hide()

  onDemoClick: (e) =>
    e.preventDefault()

    actual = $('.js-actual')
    actual.val("Exodus, Leviticus, Numbers, Deuteronomy, Joshua, Judges, Ruth, 1 Samuel, 2 Samuel, 3 Samuel, 1 Kings, 2 Kings, 1 Chronicles, 2 Chronicles, Ezra, Nehemiah, Esther, 1 Maccabees, 2 Maccabees, Job, Psalms, Proverbs, Ecclesiastes, Song of Solomon, Isaiah, Jeremiah, Lamentations, Ezekiel, Hosea, Joel, Amos, Obadiah, Jonah, Micah, Nahum, Habakkuk, Zephaniah, Haggai, Zechariah, Malachi, Matthew, Mark, Luke, John, Acts, Romans, 1 Corinthians, 2 Corinthians, Galatians, Ephesians, Philippians, Colossians, 1 Thessalonians, 2 Thessalonians, 1 Timothy, 2 Timothy, Titus, Philemon, Hebrews, James, 1 Peter, 2 Peter, 1 John, 2 John, 3 John, Jude, Book of Mormon")

    $('.js-ignore-case').prop('checked', false)

    $('.js-diff form').submit()

  onDiffSubmit: (e) =>
    e.preventDefault()

    form = e.target

    benchmark = $('.js-benchmark').val()
    actual = $('.js-actual').val()

    if benchmark || actual
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

  escapeHTML: (string) =>
    string = string.replace(/&/g, '&amp;')
    string = string.replace(/</g, '&lt;')
    string = string.replace(/>/g, '&gt;')
    string = string.replace(/"/g, '&quot;')
    string
