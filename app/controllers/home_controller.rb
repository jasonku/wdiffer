class HomeController < ApplicationController
  def index
    @diff = Diff.new
  end

  def about
  end
end
