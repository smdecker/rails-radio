class CommentsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :verify_comment, only: [:edit, :update, :destroy]

	def create
		@comment = current_user.comments.build(comment_params)

    @comment.save
    redirect_to request.referrer
	end

	def edit
	end

	def update
		if @comment.update(comment_params)
			redirect_to show_episode_path(@show, @episode), flash: {notice: "comment updated"}
		else
			render :edit
		end
	end

	def destroy
		@comment.delete
		redirect_to show_episode_path(@show, @episode), flash: {notice: "comment deleted"}
	end

  private

    def comment_params
      params.require(:comment).permit(:content, :episode_id)
    end

    def verify_comment
    	@show = Show.friendly.find(params[:show_id])
    	@episode = @show.episodes.friendly.find(params[:episode_id])
    	@comment = @episode.comments.find(params[:id])

    	redirect_to show_episode_path(@show, @episode), flash: {notice: "not authorized"} unless current_user.id == @comment.user_id
    end
end