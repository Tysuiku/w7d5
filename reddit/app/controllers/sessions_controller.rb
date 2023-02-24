class SessionsController < ApplicationController
  before_action :ensure_logged_in?, only: [:destroy]
  before_action :ensure_logged_out?, only: [:create, :new]

  def new
    render :new
  end

  def destroy
    logout!
    redirect_to new_sessions_url
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login(@user)
      flash[:messages] = ["successfully logged in"]
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["invalid credentials"]
      render :new
    end
  end
end
