class SupersController < ApplicationController
  def index
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
