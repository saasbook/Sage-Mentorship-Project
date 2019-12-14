class CheckoutsController < ApplicationController
  append_before_action :authorize_admin_or_higher, only: [:new, :create]
  append_before_action :authorize_specific_admin_or_higher, only: [:edit, :update, :destroy]
  before_action :set_checkout, only: [:edit, :update, :destroy]

  # GET /checkouts/new
  def new
    @checkout = Checkout.new
    unless params[:correspond_checkin_id].nil?
        @checkin = Checkin.find(params[:correspond_checkin_id])
        @checkout.mentor = @checkin.mentor
        @mentor_id = @checkout.mentor.id
        @checkout.school_id = @checkin.school.id
        @checkout.checkout_lat = @checkin.checkin_lat
        @checkout.checkout_lon = @checkin.checkin_lon
        @checkout.checkout_time = @checkin.checkin_time
        @checkout.isValid = true
    end
  end

  # GET /checkouts/1/edit
  def edit
    @mentor_id = @checkout.mentor_id
  end

  # POST /checkouts
  # POST /checkouts.json
  def create
    @checkout = Checkout.new(checkout_params)
    @checkout.checkout_lat = @checkout.school.lat
    @checkout.checkout_lon = @checkout.school.lon
    unless params[:mentor_id].nil?
        @checkout.mentor = Mentor.find(params[:mentor_id])
    end

    respond_to do |format|
      @checkout.date = @checkout.checkout_time.to_date
      if @checkout.save
        format.html { redirect_to @checkout.correspond_checkin, notice: 'Checkout was successfully created.' }
        format.json { render :show, status: :created, location: @checkout }
      else
        format.html { render :new }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checkouts/1
  # PATCH/PUT /checkouts/1.json
  def update
    @checkout.checkout_lat = @checkout.school.lat
    @checkout.checkout_lon = @checkout.school.lon
    unless params[:mentor_id].nil?
        @checkout.mentor = Mentor.find(params[:mentor_id])
    end

    respond_to do |format|
      @checkout.date = @checkout.checkout_time.to_date
      if @checkout.update(checkout_params)
        format.html { redirect_to @checkout.correspond_checkin, notice: 'Checkout was successfully updated.' }
        format.json { render :show, status: :ok, location: @checkout }
      else
        format.html { render :edit }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkouts/1
  # DELETE /checkouts/1.json
  def destroy
    @checkout.destroy
    respond_to do |format|
      format.html { redirect_to checkouts_url, notice: 'Checkout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Authorize only if the @current_user is a super or is admin of the mentor of this checkout
	def authorize_specific_admin_or_higher
        return if @current_user.is_a?(Super)
        return if is_admin_of_this_checkout?
        fail_authentication_redirect
	end

    def is_admin_of_this_checkout?
        this_checkout = set_checkout
        return @current_user.is_a?(Admin) && @current_user.school.id == this_checkout.mentor.school.id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_checkout
      @checkout = Checkout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checkout_params
      params.require(:checkout).permit(:checkout_time, :checkout_lat, :checkout_lon, :mentor_id, :school_id, :isValid)
    end
end
