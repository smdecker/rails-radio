class CommentsController < ApplicationController

	def create
		@comment = current_user.comments.build(comment_params)

    @comment.save
    redirect_to request.referrer
	end

  private

    def comment_params
      params.require(:comment).permit(:content, :episode_id)
    end
end