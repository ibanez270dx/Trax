class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_user
    if current_user.nil?
      flash[:notice] = "Woah there, cowboy. You gots to log in to do that."
      session[:user_requested_url] = request.url unless request.xhr?
      session[:user_id] = nil
      redirect_to user_login_path and return false
    end
  end
end
