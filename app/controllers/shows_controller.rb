class ShowsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :authenticate_admin, except: [:index, :show]
	before_action :set_show, only: [:show, :edit, :update, :destroy]

	def index
		@shows = Show.all
	end

	def show
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

	def edit
	end

	def update
		if @show.update(show_params)
			redirect_to show_path(@show), flash: {notice: "'#{@show.title}' updated"}
		else
			render :edit
		end
	end

	def destroy
		@show.delete
		redirect_to show_path, flash: {notice: "'#{@show.title}' deleted"}
	end

	private

	def set_show
		@show = Show.friendly.find(params[:id])
	end

	def authenticate_admin
		redirect_to root_path, flash: {notice: "admin only"} unless current_user && current_user.admin?
	end

	def show_params
		params.require(:show).permit(:title, :description, :location, :link, :twitter, :facebook, :soundcloud, :slug)
	end
end