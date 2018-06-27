class Shows::EpisodesController < ApplicationController
	before_action :set_show, only: [:index, :show, :new, :create]

	def index
		@episodes = Episode.all	
	end

	def show
		@user = current_user
		@episode = Episode.friendly.find(params[:id])
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

  def favorite
  	@episode = Episode.friendly.find(params[:id])
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @episode
      redirect_to show_url(@episode.show_id)

    elsif type == "unfavorite"
      current_user.favorites.delete(@episode)
      redirect_to show_url(@episode.show_id)

    else
      # Type missing, nothing happens
      redirect_to show_url(@episode.show_id)
    end
  end

	private

	def set_show
		@show = Show.friendly.find(params[:show_id])
	end

	def episode_params
		params.require(:episode).permit(:title, :description, :air_date, :slug)
	end
end