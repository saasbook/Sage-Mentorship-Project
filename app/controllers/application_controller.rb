class ApplicationController < ActionController::Base
	def require_login
  		if !session[:user_id]
        	redirect_to root_url
    	end
	end
end
