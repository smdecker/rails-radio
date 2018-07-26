class Shows::EpisodesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :explore]
	before_action :authenticate_admin, except: [:index, :show, :favorite, :explore]
	before_action :set_show, except: [:index, :favorite, :explore]
	before_action :set_episode, only: [:show, :edit, :update, :destroy]

	def index
		@episodes = Episode.recent_episodes
	end

	def show
		@user = current_user
	end

	def new
		@episode = @show.episodes.new		
	end

	def create
		@episode = @show.episodes.new(episode_params)

		@episode.user = current_user

		if @episode.save
			redirect_to show_episode_path(@show, @episode)
		else 
			render :new
		end
	end

	def edit
	end

	def update
		if @episode.update(episode_params)
			redirect_to show_episode_path(@show, @episode), flash: {notice: "'#{@episode.title}' updated"}
		else
			render :edit
		end
	end

	def destroy
		@episode.delete
		redirect_to show_path(@show), flash: {notice: "'#{@episode.title}' deleted"}
	end

  def favorite
  	@episode = Episode.friendly.find(params[:id])

    if params[:type] == "favorite"
      current_user.favorites << @episode
      redirect_to request.referrer

    elsif params[:type] == "unfavorite"
      current_user.favorites.delete(@episode)
      redirect_to request.referrer

    else
      redirect_to request.referrer
    end
  end

	def explore
		@genres = Genre.genre_order

	  @explore = Episode.search(params[:q])
	  @explore_results = @explore.result(distinct: true)
	end

	private

	def authenticate_admin
		redirect_to root_path, flash: {alert: "ADMIN ONLY"} unless current_user && current_user.admin?
	end

	def set_episode
		@episode = Episode.friendly.find(params[:id])
	end

	def set_show
		@show = Show.friendly.find(params[:show_id])
	end

	def episode_params
		params.require(:episode).permit(:title, :description, :air_date, :slug, :avatar, :genres_name_cont_any, genre_ids:[], genres_attributes: [:name] )
	end
end