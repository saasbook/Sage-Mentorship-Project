class LoginsController < ApplicationController
  def new
  end

  def create
    if user = authenticate_with_google
      cookies.signed[:user_id] = user.id
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
      Rails.logger.debug GoogleSignIn::Identity.new(user_token).email_address
      Mentor.find_by email: GoogleSignIn::Identity.new(user_token).email_address
    elsif error = flash[:google_sign_in_token].error
      logger.error "Google authentication error: #{error}"
      nil
    end
  end
end
