class GoalsController < ApplicationController
  before_action :require_sign_in
  before_action :require_user_to_own_goal, only: [:edit, :update, :destroy]
  
  def new
    @user = User.find(params[:user_id])
    @goal = Goal.new
  end
  
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end
  
  def show
    @goal = Goal.find(params[:id])
  end
  
  def index
    @goals = Goal.where('user_id = ?', params[:user_id])
  end
  
  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_goals_url(current_user)
  end
  
  def edit
    @goal = Goal.find(params[:id])
  end
  
  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end
  
  def goal_params
    params.require(:goal).permit(:title, :description, :completion)
  end
end
