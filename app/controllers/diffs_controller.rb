class DiffsController < ApplicationController
  def create
    diff = Diff.new(params[:diff])

    render json: {
      success: true,
      results: diff.to_html,
    }
  end
end
