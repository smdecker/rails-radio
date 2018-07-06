class Shows::EpisodesController < ApplicationController
	before_action :set_show, except: [:index]
	before_action :set_episode, only: [:show, :edit, :update, :destroy]

	def index
		@episodes = Episode.all	
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

	def set_episode
		@episode = Episode.friendly.find(params[:id])
	end

	def set_show
		@show = Show.friendly.find(params[:show_id])
	end

	def episode_params
		params.require(:episode).permit(:title, :description, :air_date, :slug, :avatar)
	end
end