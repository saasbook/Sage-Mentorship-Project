class ApplicationController < ActionController::Base
  def https_redirect
    redirect_to :protocol => "https://" unless (request.ssl? || request.local?)
  end
  before_filter :https_redirect
end
