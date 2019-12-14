class AdminsController < ApplicationController
  append_before_action :authorize_super, only: [:_index, :new, :create, :edit, :update, :destroy]
  append_before_action :authorize_specific_admin_or_higher, only: [:show]
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def _index
      @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
      redirect_to @admin.school
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
    respond_to do |format|
      format.html {  redirect_to @current_user, notice: "Admin '#{@admin.name}' was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

    # Authorize only if the @current_user is this admin
	def authorize_specific_admin_or_higher
    	return if @current_user.is_a?(Super)
        return if is_this_admin?
        fail_authentication_redirect
	end

    def is_this_admin?
        this_admin = set_admin
        return @current_user.is_a?(Admin) && @current_user.id == this_admin.id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:name, :email, :school_id)
    end
end
