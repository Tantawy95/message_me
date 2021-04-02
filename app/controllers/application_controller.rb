class ApplicationController < ActionController::Base


  helper_method :current_user, :logged_in?, :online_users

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

  def online_users
    @users = User.all
    @online_users = []
    @users.each do |u|
      if u.is_online == true
        @online_users << u
      end
    end
  end

end
