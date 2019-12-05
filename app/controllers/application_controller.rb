class ApplicationController < ActionController::Base
    before_action :get_user, :require_login

    def get_user
        @current_user = find_user_by_email(session[:email_address])
    end

	def require_login
    	get_user
  		redirect_to root_url if @current_user.nil?
	end

	def authorize_admin_or_higher
	    fail_authentication_redirect unless @current_user.is_a?(Admin) || @current_user.is_a?(Super)
	end

	def authorize_super
	    fail_authentication_redirect unless @current_user.is_a?(Super)
	end

	def fail_authentication_redirect
	    flash[:notice] = "You don't have access to that page!"
        redirect_to root_path
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
