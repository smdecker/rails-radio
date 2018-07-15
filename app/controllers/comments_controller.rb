class CommentsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]




	def show
		@show = Show.friendly.find(params[:show_id])
		@episode = Episode.friendly.find(params[:episode_id])
		@comment = @episode.comments.find(params[:id])
	end

	def create
		@comment = current_user.comments.build(comment_params)

    @comment.save
    redirect_to request.referrer
	end

	def edit
		@show = Show.friendly.find(params[:show_id])
		@episode = @show.episodes.friendly.find(params[:episode_id])
		@comment = @episode.comments.find(params[:id])
	end

	def update
		@show = Show.friendly.find(params[:show_id])
		@episode = @show.episodes.friendly.find(params[:episode_id])
		@comment = @episode.comments.find(params[:id])
		if @comment.update(comment_params)
			redirect_to show_episode_path(@show, @episode), flash: {notice: "comment updated"}
		else
			render :edit
		end
	end

	def destroy
				@show = Show.friendly.find(params[:show_id])
		@episode = Episode.friendly.find(params[:episode_id])
		@comment = @episode.comments.find(params[:id])

		@comment.delete
		redirect_to show_episode_path(@show, @episode), flash: {notice: "comment deleted"}
	end

  private

    def comment_params
      params.require(:comment).permit(:content, :episode_id)
    end

def set_episode
	@episode = Episode.friendly.find(params[:episode_id])
end

    def find_comment
    	@comment = @episode.comment.find(params[:id])
    end

    def comment_user
    	redirect_to root_path, flash: {notice: "not authorized"} unless current_user.id == @comment.user_id
    end
end