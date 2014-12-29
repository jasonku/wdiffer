class HomeController < ApplicationController
  def index
    @diff = Diff.new
  end
end
