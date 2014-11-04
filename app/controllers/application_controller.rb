class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user
  
  def log_in!
    session[:session_token] = @user.reset_session_token!
  end
  
  def logged_in?
    !!current_user
  end
  
  def current_user
    User.find_by_session_token(session[:session_token])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
  
  def require_sign_in
    redirect_to new_session_url unless logged_in?
  end
  
  def require_user_to_own_goal
    unless Goal.find(params[:id]).user_id == current_user.id
      redirect_to user_goals_url(current_user) 
    end
  end
end
