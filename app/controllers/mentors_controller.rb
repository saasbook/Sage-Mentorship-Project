class MentorsController < ApplicationController
  append_before_action :authorize_super, only: [:_index]
  append_before_action :authorize_admin_or_higher, only: [:new, :create]
  append_before_action :authorize_specific_admin_or_higher, only: [:edit, :update, :destroy]
  append_before_action :authorize_specific_mentor_admin_or_higher, only: [:show, :attendances]
  append_before_action :authorize_specific_mentor, only: [:appointment, :checkin, :checkout, :checkin_loc, :checkout_loc]
  before_action :set_mentor, only: [:show, :edit, :update, :destroy, :attendances, :appointment, :checkin, :checkout, :checkin_loc, :checkout_loc]

  # GET /mentors
  # GET /mentors.json
  def _index
    @mentors = Mentor.all
    respond_to do |format|
    format.xlsx {
      response.headers[
        'Content-Disposition'
      ] = "attachment; filename=mentor_reports_#{Date.today}.xlsx"
    }
    format.html { render :_index }
  end
    Rails.logger.debug params.keys
  end

  # GET /mentors/1/details
  # show the weeks summary of the mentor
  def show
  end

  # GET /mentors/1/attendances
  # show the detailed attendances list of the mentor at a specific week
  def attendances
    @week_date = params[:week_date].nil? ? Time.current.beginning_of_week : Time.strptime(params[:week_date], "%m/%d/%Y").beginning_of_week
  end

  # GET /mentors/new
  def new
    @mentor = Mentor.new
  end

  # GET /mentors/1/edit
  def edit
  end

  # POST /mentors
  # POST /mentors.json
  def create
    @mentor = Mentor.new(mentor_params)
    respond_to do |format|
      if @mentor.save
        format.html { redirect_to @current_user, notice: "Mentor #{@mentor.name} was successfully created." }
        format.json { render :show, status: :created, location: @mentor }
      else
        format.html { render :new }
        format.json { render json: @mentor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mentors/1
  # PATCH/PUT /mentors/1.json
  def update
    respond_to do |format|
      if @mentor.update(mentor_params)
        format.html { redirect_to @current_user, notice: "Mentor #{@mentor.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @mentor }
      else
        format.html { render :edit }
        format.json { render json: @mentor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentors/1
  # DELETE /mentors/1.json
  def destroy
    @mentor.destroy
    respond_to do |format|
      format.html { redirect_to @current_user, notice: "Mentor #{@mentor.name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def checkin_loc
  @chk_in = Checkin.new(:mentor_id => @mentor.id,
                        :school_id =>@mentor.school_id,
                        :checkin_time=> Time.current,
                        :checkin_lat => params[:la],
                        :checkin_lon => params[:lo],
                        :isValid => my_school.in_range?([@lat, @lon]),
                        :date => Date.today
                        )
  flash[:notice] = @chk_in.save ? 'Checkin succesful' : 'Something went wrong. Please try again.'
  redirect_to mentor_path
  end

def checkout_loc
    #Checks if the mentor is not signed it already. If not then won't let mentors to checkout
  if Checkin.find_by(mentor_id: @mentor.id, date: Date.today).nil?
    flash[:notice] = 'No checkin exists to checkout'
    redirect_to mentor_path
  else
   @chk_out = Checkout.new(:mentor_id => @mentor.id,
                          :school_id => @mentor.school_id,
                          :checkout_time=> Time.current,
                          :checkout_lat => params[:la],
                          :checkout_lon => params[:lo],
                          :ischeckout => true,
                          :isValid => my_school.in_range?([@lat, @lon]),
                          :date => Date.today
                          )
    flash[:notice] = @chk_out.save ? 'Checkout succesful' : 'Something went wrong. Please try again.'
    redirect_to mentor_path
    end
  end

  
  def appointment
  end


  private

    # Authorize only if the @current_user is a super or is admin of this mentor
	def authorize_specific_admin_or_higher
        return if @current_user.is_a?(Super)
        return if is_admin_of_this_mentor?
        fail_authentication_redirect
	end

	# Authorize only if the @current_user is this mentor or the admin of this mentor or a super
	def authorize_specific_mentor_admin_or_higher
    fail_authentication_redirect unless (@current_user.is_a?(Super) || is_admin_of_this_mentor? || is_this_mentor?)
  end

    # Authorize only if the @current_user is this mentor
	def authorize_specific_mentor
    fail_authentication_redirect unless is_this_mentor?
	end

    def is_this_mentor?
        this_mentor = set_mentor
        return @current_user.is_a?(Mentor) && @current_user.id == this_mentor.id
    end

    def is_admin_of_this_mentor?
        this_mentor = set_mentor
        return @current_user.is_a?(Admin) && @current_user.school.id == this_mentor.school.id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_mentor
      @mentor = Mentor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mentor_params
      params.require(:mentor).permit(:name, :email, :school_id)
    end

  def my_school
    @school = School.find(@mentor.school_id)
  end
end
