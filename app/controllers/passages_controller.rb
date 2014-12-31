class PassagesController < ApplicationController
  def index
    query = params[:q]
    version = params[:version]

    passages = Passage.new(query, version).content

    render json: passages
  end
end
