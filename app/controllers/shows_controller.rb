class ShowsController < ApplicationController

	def index
		@shows = Show.all
	end

	def show
		@show = Show.friendly.find(params[:id])
	end

	def new
		@show = Show.new
	end

	def create
		@show = Show.new(show_params)
		if @show.save
			redirect_to show_path(@show)
		else
			render :new
		end
	end

	private

	def show_params
		params.require(:show).permit(:title, :description, :location, :link, :twitter, :facebook, :soundcloud, :slug)
	end
end