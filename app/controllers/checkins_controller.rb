class CheckinsController < ApplicationController
  append_before_action :authorize_admin_or_higher, only: [:new, :create]
  append_before_action :authorize_specific_admin_or_higher, only: [:show, :edit, :update, :destroy]
  before_action :set_checkin, only: [:show, :edit, :update, :destroy]

  # GET /checkins/1
  # GET /checkins/1.json
  def show
    @checkout = @checkin.correspond_checkout
  end

  # GET /checkins/new
  def new
    @checkin = Checkin.new
    unless params[:mentor_id].nil?
        mentor = Mentor.find(params[:mentor_id])
        school = mentor.school
        @checkin.mentor = mentor
        @checkin.school_id = school.id
        @checkin.checkin_lat = school.lat
        @checkin.checkin_lon = school.lon
        @checkin.isValid = true
    end
  end

  # GET /checkins/1/edit
  def edit
  end

  # POST /checkins
  # POST /checkins.json
  def create
    @checkin = Checkin.new(checkin_params)
    respond_to do |format|
      @checkin.date = @checkin.checkin_time.to_date
      if @checkin.save
        format.html { redirect_to @checkin, notice: 'Checkin was successfully created.' }
        format.json { render :show, status: :created, location: @checkin }
      else
        format.html { render :new }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checkins/1
  # PATCH/PUT /checkins/1.json
  def update
    respond_to do |format|
      @checkin.date = @checkin.checkin_time.to_date
      if @checkin.update(checkin_params)
        format.html { redirect_to @checkin, notice: 'Checkin was successfully updated.' }
        format.json { render :show, status: :ok, location: @checkin }
      else
        format.html { render :edit }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkins/1
  # DELETE /checkins/1.json
  def destroy
    @checkin.destroy
    respond_to do |format|
      format.html { redirect_to checkins_url, notice: 'Checkin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Authorize only if the @current_user is a super or is admin of the mentor of this checkin
	def authorize_specific_admin_or_higher
        return if @current_user.is_a?(Super)
        return if is_admin_of_this_checkin?
        fail_authentication_redirect
	end

    def is_admin_of_this_checkin?
        this_checkin = set_checkin
        return @current_user.is_a?(Admin) && @current_user.school.id == this_checkin.mentor.school.id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_checkin
      @checkin = Checkin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checkin_params
      params.require(:checkin).permit(:checkin_time, :checkin_lat, :checkin_lon, :mentor_id, :school_id, :isValid)
    end
end
