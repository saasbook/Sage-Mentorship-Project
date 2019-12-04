class SchoolsController < ApplicationController
  append_before_action :authorize_super, only: [:_index, :new, :edit, :create, :update, :destroy]
  append_before_action :authorize_specific_admin_or_higher, only: [:show]
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  # GET /schools
  # GET /schools.json
  def _index
    @schools = School.all
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
      if params[:week_date].nil?
        @week_date = Time.current
      else
        @week_date = Time.strptime(params[:week_date], "%m/%d/%Y")
      end
      @week_date = @week_date.beginning_of_week
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
    respond_to do |format|
      format.html { redirect_to @current_user, notice: "#{@school.name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

    # Authorize only if the @current_user is a super or is admin of this school
	def authorize_specific_admin_or_higher
        return if @current_user.is_a?(Super)
        return if is_admin_of_this_school?
        fail_authentication_redirect
	end

    def is_admin_of_this_school?
        this_school = set_school
        return @current_user.is_a?(Admin) && @current_user.school.id == this_school.id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:name, :address, :lat, :lon)
    end
end
