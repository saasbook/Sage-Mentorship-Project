class LoginsController < ApplicationController
  def new
  end

  def create
    if user = authenticate_with_google
      cookies.signed[:user_id] = user.id
      session[:user_id] = user.id
      flash[:notice] = user
      redirect_to user
    else
      redirect_to new_session_url, alert: 'authentication_failed'
    end
  end

  private
  def authenticate_with_google
    if flash
      Rails.logger.debug 'Flash keys below'
      Rails.logger.debug flash.keys


    end
    if user_token = flash[:google_sign_in_token]
      find_user(user_token)
      #Rails.logger.debug GoogleSignIn::Identity.new(user_token).email_address
      #Mentor.find_by email: GoogleSignIn::Identity.new(user_token).email_address
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
