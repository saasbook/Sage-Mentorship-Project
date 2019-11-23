class ApplicationController < ActionController::Base
	def require_login
  		if !session[:email_address]
        	redirect_to root_url
    	end
	end

	private
	def model_name
		self.controller_name.singularize.classify.constantize
	end

	private
	def find_user_by_email(email_address)
		user = Mentor.find_by(email: email_address) || Admin.find_by(email: email_address) || Super.find_by(email: email_address)
	end
end
