class SchoolsController < ApplicationController
  before_action :require_login
  before_action :authorize_admin
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  # GET /schools
  # GET /schools.json
  def _index
    @schools = School.all
  end

  # GET /schools/1
  # GET /schools/1.json
  def show

    @present_week = Time.current.beginning_of_week.utc
    @week_of = Time.zone.parse("0:0am Oct 21st, 2019").utc

    @totalhours_list = @school.totalhours_list(@week_of)

  end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)
    @current_user = find_user_by_email(session[:email_address])
    respond_to do |format|
      if @school.save
        format.html { redirect_to @current_user, notice: "School '#{@school.name}' was successfully created." }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    @current_user = find_user_by_email(session[:email_address])
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @current_user, notice: "#{@school.name}' was successfully updated." }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    @current_user = find_user_by_email(session[:email_address])
    respond_to do |format|
      format.html { redirect_to @current_user, notice: "#{@school.name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:name, :address, :lat, :lon)
    end
end
