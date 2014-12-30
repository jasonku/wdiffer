class Diff
  include ActiveModel::Model

  class << self
    include HTMLDiff
  end

  attr_accessor :expected, :actual

  def to_html(options)
    ignore_case = options[:ignore_case]

    if @expected.present?
      @expected = CGI::escape_html(@expected)
    end

    if @actual.present?
      @actual = CGI::escape_html(@actual)
    end

    if ignore_case
      @expected.downcase!
      @actual.downcase!
    end

    diff =
      if @expected.present? || @actual.present?
        Diff.diff(@actual, @expected)
      end

    diff || "No diff."
  end
end
