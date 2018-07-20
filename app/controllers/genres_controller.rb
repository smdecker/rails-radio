class GenresController < ApplicationController

	def show
		@genre = Genre.friendly.find(params[:id])
	end
end