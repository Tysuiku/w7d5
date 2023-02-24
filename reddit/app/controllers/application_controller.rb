class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  helper_method :current_user, :logged_in?, :auth_token
  #CHELLL
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def ensure_logged_in?
    redirect_to new_sessions_url unless logged_in?
  end

  def ensure_logged_out?
    redirect_to new_sessions_url if logged_in?
  end

  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
    current_user = nil
  end

  def auth_token
    "<input 
            type='hidden'
            name='authenticity_token'
            value='#{form_authenticity_token}'>".html_safe
  end
end
