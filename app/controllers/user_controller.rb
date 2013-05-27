class UserController < ApplicationController

  def login
    if request.post?
      if @user = User.find_by_login(params[:user][:login])
        if @user.authenticate(params[:user][:password])
          session[:user_id] = @user.id
          redirect_to session[:user_requested_url] || dashboard_path
          session[:user_requested_url] = nil
        else
          flash.now[:error] = "Your password is incorrect."
        end
      else
        flash.now[:error] = "There is no user with that login."
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to user_login_path
  end

end
