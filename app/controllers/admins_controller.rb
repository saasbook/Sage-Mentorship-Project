class AdminsController < ApplicationController
  before_action :require_login
  before_action :authorize_admin
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def _index
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
#    if session[:id].to_i == params[:id].to_i
      redirect_to @admin.school
#    else
#      flash[:notice] = "You don't have access to that page!"
#      redirect_to admin_path(session[:id])
#    end
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
    @current_user = find_user_by_email(session[:email_address])
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
    @current_user = find_user_by_email(session[:email_address])
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
    @current_user = find_user_by_email(session[:email_address])
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
