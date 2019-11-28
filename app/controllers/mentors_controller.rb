class MentorsController < ApplicationController
  before_action :require_login
  before_action :set_mentor, only: [:show, :edit, :update, :destroy, :attendances]

  # GET /mentor/checkin
  def checkin
  end

  # GET /mentor/checkout
  def checkout
  end

  # GET /mentors
  # GET /mentors.json
  def _index
    @mentors = Mentor.all
    Rails.logger.debug params.keys
  end

  # GET /mentors/1/details
  def show
  end


  # GET /mentors/1/attendances
  def attendances
    if params[:week_date].nil?
      @week_date = Time.now
    else
      @week_date = DateTime.strptime(params[:week_date], "%m/%d/%Y")
    end
    @week_date = @week_date.beginning_of_week.utc
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
    @current_user = find_user_by_email(session[:email_address])
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
    @current_user = find_user_by_email(session[:email_address])
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
    @current_user = find_user_by_email(session[:email_address])
    respond_to do |format|
      format.html { redirect_to @current_user, notice: "Mentor #{@mentor.name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def checkin_loc
    @time = Time.now
    @mentor = Mentor.find(params[:id])
    puts @mentor.name
    @lat = params[:la]
    @lon = params[:lo]
    @chk_in = Checkin.new(:mentor_id => @mentor.id, :school_id =>@mentor.school_id, :checkin_time=> Time.now, :lat => @lat, :lon => @lon)
    if @chk_in.save
        flash[:notice] = 'Checkin succesful'
        redirect_to mentor_checkin_url
    else
      redirect_to mentor_path
      flash[:notice] = 'something wrong, please try again'
    end
  end


  def checkout_loc
    @mentor = Mentor.find(params[:id])
    @time = Time.now
    @lat = params[:la]
    @lon = params[:lo]
    @chk_out = Checkout.new(:mentor_id => @mentor.id, :school_id =>@mentor.school_id, :checkout_time=> Time.now, :lat => @lat, :lon => @lon, :ischeckout => true)
    if @chk_out.save
        flash[:notice] = 'Checkout succesful'
        redirect_to mentor_checkout_url
    else
      redirect_to mentor_path
      flash[:notice] = 'something wrong, please try again'
    end
  end

  def checkin
    @mentor = Mentor.find(params[:id])
    @time = Time.now
  end

  def checkout
    @mentor = Mentor.find(params[:id])
    @time = Time.now
  end




  def appointment
    @mentor = Mentor.find(params[:id])
    #session[:user_id] = @mentor.id
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mentor
      @mentor = Mentor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mentor_params
      params.require(:mentor).permit(:name, :email, :school_id)
    end


end
