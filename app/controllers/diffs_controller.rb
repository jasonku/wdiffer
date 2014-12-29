class DiffsController < ApplicationController
  def create

    @diff = Diff.new(params[:diff])

  end
end
