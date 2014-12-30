class DiffsController < ApplicationController
  def create
    options = params[:options] || {}

    diff = Diff.new(params[:diff])
    results = diff.to_html(options)

    render json: {
      success: true,
      results: results,
    }
  end
end
