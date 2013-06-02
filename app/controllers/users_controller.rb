class UsersController < ApplicationController

  def signup
    @user = User.new

    if request.post?
      @user = User.create user_params

      if @user.valid?
        session[:user_id] = @user.id
        flash[:success] = "Welcome to Trax"
        redirect_to dashboard_path
      end
    end
  end

  ###############################
  # Authentication
  ###############################

  def login
    if request.get? && current_user
      redirect_to dashboard_path and return
    elsif request.post?
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
    flash[:success] = "You have been logged out."
    redirect_to user_login_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :login, :password, :password_confirmation, :soundcloud_id)
    end

end
