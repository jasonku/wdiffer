class Diff
  include ActiveModel::Model

  class << self
    include HTMLDiff
  end

  attr_accessor :expected, :actual

  def to_html
    Diff.diff(expected, actual)
  end
end
