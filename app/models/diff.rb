class Diff
  include ActiveModel::Model

  class << self
    include HTMLDiff
  end

  attr_accessor :expected, :actual

  def to_html
    diff =
      if expected.present? || actual.present?
        Diff.diff(expected, actual)
      end

    diff || "No diff."
  end
end
