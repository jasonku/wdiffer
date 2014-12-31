class PassagesController < ApplicationController
  def index
    query = params[:q]
    version = params[:version]

    passages = Passage.new(query, version).content

    if passages
      render json: passages
    else
      render json: {
        error: true
      }, status: 500
    end
  end
end
