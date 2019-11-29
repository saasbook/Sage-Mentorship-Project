class SupersController < ApplicationController
  before_action :require_login
  before_action :authorize_super
  def index
  end

  def new
  end

  def show
    if session[:id].to_i == params[:id].to_i
    @schools = School.all
    @mentors = Mentor.all
    @admins = Admin.all
    @supers = Super.all
    else
      flash[:notice] = "You don't have access to that page!"
      redirect_to super_path(session[:id]) 
  end
  end

  def delete
  end
end
