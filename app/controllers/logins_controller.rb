class LoginsController < ApplicationController
  def new
  end


  def create
    if user = authenticate_with_google
      cookies.signed[:user_id] = user.id
      session[:user_id] = user.id
      redirect_to user
    else
      session[:user_id] = nil if session[:user_id]
      redirect_to root_path, notice: 'User does not exist.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  private
  def authenticate_with_google
    if flash
      Rails.logger.debug 'Flash keys below'
      Rails.logger.debug flash.keys
    end
    if user_token = flash[:google_sign_in_token]
      find_user(user_token)
    elsif error = flash[:google_sign_in_token].error
      logger.error "Google authentication error: #{error}"
      nil
    end
  end

  private
  def find_user(user_token)
    user = Mentor.find_by email: GoogleSignIn::Identity.new(user_token).email_address

    user ||= Admin.find_by email: GoogleSignIn::Identity.new(user_token).email_address
    user ||= Super.find_by email: GoogleSignIn::Identity.new(user_token).email_address
  end
end
