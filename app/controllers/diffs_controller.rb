class DiffsController < ApplicationController
  def create
    options = params[:options]

    diff = Diff.new(params[:diff])

    render json: {
      success: true,
      results: diff.to_html,
    }
  end
end
