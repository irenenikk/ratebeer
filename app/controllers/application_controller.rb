class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice:'You have to be signed in to access this page' if current_user.nil?
  end

  def isadmin?
    redirect_to :back, notice:'You have to be admin to do this' if current_user.admin? == false
  end

end
