class CheckinsController < ApplicationController
  before_action :require_login
  before_action :set_checkin, only: [:show, :edit, :update, :destroy]

  # GET /checkins/1
  # GET /checkins/1.json
  def show
    email_address = session[:email_address]
    user = Admin.find_by(email: email_address) || Super.find_by(email: email_address)
    if user.blank?
      redirect_to mentor_path(session[:id])
    end
    @checkout = @checkin.correspond_checkout
  end

  # GET /checkins/new
  def new
    email_address = session[:email_address]
    user = Admin.find_by(email: email_address) || Super.find_by(email: email_address)
    if user.blank?
      redirect_to mentor_path(session[:id])
    end
    @checkin = Checkin.new
  end

  # GET /checkins/1/edit
  def edit
    email_address = session[:email_address]
    user = Admin.find_by(email: email_address) || Super.find_by(email: email_address)
    if user.blank?
      redirect_to mentor_path(session[:id])
    end
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
    email_address = session[:email_address]
    user = Admin.find_by(email: email_address) || Super.find_by(email: email_address)
    if user.blank?
      redirect_to mentor_path(session[:id])
    end
    @checkin.destroy
    respond_to do |format|
      format.html { redirect_to checkins_url, notice: 'Checkin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkin
      @checkin = Checkin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checkin_params
      params.require(:checkin).permit(:checkin_time, :checkin_lat, :checkin_lon, :mentor_id, :school_id, :isValid)
    end
end
