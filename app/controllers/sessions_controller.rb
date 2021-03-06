class SessionsController < ApplicationController

  before_action :logged_in_redirect, only: [:new, :create]

  def new

  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      user.is_online = true
      user.save
      flash[:success] = "Logged in successfully"
      redirect_to root_path
    else
      flash.now[:error] = "Something went wrong with your login information"
      render 'new'
    end

  end

  def destroy
    current_user.is_online = nil
    current_user.save
    session[:user_id] = nil
    flash[:success] = "Logged out successfully"
    redirect_to login_path
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to root_path
    end
  end

end
