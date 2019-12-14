class SupersController < ApplicationController
  append_before_action :authorize_super
  before_action :set_super, only: [:show, :edit, :update, :destroy]

  def _index
    @supers = Super.all
  end

  def show
      @schools = School.all
      @mentors = Mentor.all
      @admins = Admin.all
      @supers = Super.all
  end

  def new
      @super = Super.new
  end

  # GET /supers/1/edit
  def edit
  end

  #GET /supers/cleanup
  #Careful with this route, it deletes all data from the db
  def cleandb
  Checkin.delete_all
  Checkout.delete_all
  redirect_to super_path

  end

  # POST /supers
  # POST /supers.json
  def create
    @super = Super.new(super_params)
    respond_to do |format|
      if @super.save
        format.html { redirect_to @current_user, notice: "Super '#{@super.name}' was successfully created." }
        format.json { render :show, status: :created, location: @super }
      else
        format.html { render :new }
        format.json { render json: @super.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supers/1
  # PATCH/PUT /supers/1.json
  def update
    respond_to do |format|
      if @super.update(super_params)
        format.html { redirect_to @current_user, notice: "#{@super.name}' was successfully updated." }
        format.json { render :show, status: :ok, location: @super }
      else
        format.html { render :edit }
        format.json { render json: @super.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supers/1
  # DELETE /supers/1.json
  def destroy
    if @super.id == @current_user.id
      respond_to do |format|
        format.html { redirect_to @current_user, notice: "#{@super.name} cannot be deleted as that is the signed-in account." }
        format.json { head :no_content }
      end
    else
      @super.destroy
      respond_to do |format|
        format.html { redirect_to @current_user, notice: "#{@super.name} was successfully deleted." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_super
      @super = Super.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def super_params
      params.require(:super).permit(:name, :email)
    end

end
