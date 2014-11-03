class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_credentials(user_params)
    if @user
      log_in!
      redirect_to users_url
    else
      flash.now[:errors] = ["Invalid credentials"]
      render :new
    end
  end
  
  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
