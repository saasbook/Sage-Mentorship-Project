class ReportController < ApplicationController
	before_action :require_login
	before_action :authorize_admin_or_higher
	def report_time

	end
end
