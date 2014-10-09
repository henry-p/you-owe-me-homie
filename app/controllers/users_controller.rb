class UsersController < ApplicationController
  before_filter :redirect_if_not_logged_in, except: [:new, :create]

  def new
    if logged_in?
      redirect_to user_path(current_user)
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def show
    @groups = current_user.groups
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

  def redirect_if_not_logged_in
    redirect_to root_path unless logged_in?
  end
end
