class GoalCommentsController < ApplicationController
  def create
    @comment = GoalComment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    redirect_to goal_url(@comment.goal)
  end
  
  def destroy
    @comment = GoalComment.find(params[:id])
    @comment.destroy
    redirect_to goal_url(@comment.goal)
  end
  
  def comment_params
    params.require(:comment).permit(:body, :goal_id)
  end
end
