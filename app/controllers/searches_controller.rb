class SearchesController < ApplicationController

	def index
     @listings = Listing.where(["lower(name) LIKE ?","%#{params[:search]}%"])

    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: searches_path }
    end
  end
end
