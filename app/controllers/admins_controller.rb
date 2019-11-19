class AdminsController < ApplicationController
  before_action :require_login
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admin/checkin
  def checkin
  end

  # GET /admins
  # GET /admins.json
  def _index
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show

    @present_week = Time.current.beginning_of_week.utc
    #@week_of = Time.zone.parse("0:0am Oct 21st, 2019").utc
    @school = School.find(@admin.school_id)
    @totalhours_list = @admin.totalhours_list(@present_week)

  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)
    @current_user = Super.find(session[:user_id])
    respond_to do |format|
      if @admin.save
        format.html { redirect_to @current_user, notice: "Admin '#{@admin.name}' was successfully created." }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    @current_user = Super.find(session[:user_id])
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @current_user, notice: "Admin '#{@admin.name}' was successfully updated." }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    @current_user = Super.find(session[:user_id])
    respond_to do |format|
      format.html {  redirect_to @current_user, notice: "Admin '#{@admin.name}' was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:name, :email, :school_id)
    end
end
