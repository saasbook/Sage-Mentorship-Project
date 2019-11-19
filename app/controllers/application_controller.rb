class ApplicationController < ActionController::Base
  before_action :get_user

	def require_login
  		if !session[:user_id]
        	redirect_to root_url
    	end
	end

    def get_user
      @current_user = Mentor.find_by email: session[:user_email]
      @current_user ||= Admin.find_by email: session[:user_email]
      @current_user ||= Super.find_by email: session[:user_email]
    end

end
