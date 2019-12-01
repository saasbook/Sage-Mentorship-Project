class ApplicationController < ActionController::Base
  before_action :get_user

	def require_login
  		if !session[:email_address]
        	redirect_to root_url
    	end
	end

  def get_user
      @current_user = find_user_by_email(session[:email_address])
  end

	private
	def model_name
		self.controller_name.singularize.classify.constantize
	end

	private
	def find_user_by_email(email_address)
		user = Mentor.find_by(email: email_address) || Admin.find_by(email: email_address) || Super.find_by(email: email_address)
	end


	def authorize_admin
		email_address = session[:email_address]
		user = Admin.find_by(email: email_address) || Super.find_by(email: email_address)
		if user.blank?
			redirect_to root_url
		end
	end

	def authorize_super
		email_address = session[:email_address]
		user = Super.find_by(email: email_address)
		if user.blank?
			redirect_to root_url
		end
	end

end
