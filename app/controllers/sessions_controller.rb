class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:user_email] )
    if user && user.authenticate(params[:user_password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = "Invalid email or password"
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  def new
  end
end
