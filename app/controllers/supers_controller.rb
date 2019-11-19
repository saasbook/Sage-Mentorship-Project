class SupersController < ApplicationController
  before_action :require_login

  def _index
    @supers = Super.all
  end

  def new
  end

  def show
    @schools = School.all
    @mentors = Mentor.all
    @admins = Admin.all
    @supers = Super.all
  end

  def delete
  end
end
