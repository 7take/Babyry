class CommentsController < ApplicationController
	before_action :authenticate_user!


	def create
		@baby = Baby.find(params[:baby_id])
		#投稿に紐づいたコメントを作成
		@comment = @baby.comments.new(comment_params)
		@comment.user_id = current_user.id
	if @comment.save
		flash[:success] = "Comment was successfully created."
	end
		# redirect_to request.referer
	end


	def destroy
		@baby = Baby.find(params[:baby_id])
		@comment = current_user.comments.find_by(id: params[:id], baby_id: @baby.id)
		@comment.destroy
		# redirect_to request.referer
	end


	private
	def comment_params
		params.require(:comment).permit(:comment)
	end


end