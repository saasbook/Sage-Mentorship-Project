class LoginsController < ApplicationController
  def new
  end

  def create
    if user = authenticate_with_google
      cookies.signed[:user_id] = user.id
      session[:email_address] = user.email
      redirect_to user
    else
      session[:email_address] = nil if session[:user_id]
      redirect_to root_path, notice: 'User does not exist.'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:email_address] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  private
  def authenticate_with_google
    if user_token = flash[:google_sign_in_token]
      find_user_by_email(get_email_from_token(user_token))
    elsif error = flash[:google_sign_in_token].error
      logger.error "Google authentication error: #{error}"
      nil
    end
  end

  private
  def get_email_from_token(user_token)
    (sign_in_token = GoogleSignIn::Identity.new(user_token)) ? sign_in_token.email_address : nil
  end
end
