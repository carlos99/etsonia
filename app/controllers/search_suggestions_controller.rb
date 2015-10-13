class SearchSuggestionsController < ApplicationController
	def index
		render json: %w[foo bar tcs zte]
	end
end
