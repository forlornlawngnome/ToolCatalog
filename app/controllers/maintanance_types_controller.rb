class MaintananceTypesController < ApplicationController
  before_action :set_maintanance_type, only: [:show, :edit, :update, :destroy]

  # GET /maintanance_types
  # GET /maintanance_types.json
  def index
    @maintanance_types = MaintananceType.all
  end

  # GET /maintanance_types/1
  # GET /maintanance_types/1.json
  def show
  end

  # GET /maintanance_types/new
  def new
    @maintanance_type = MaintananceType.new
  end

  # GET /maintanance_types/1/edit
  def edit
  end

  # POST /maintanance_types
  # POST /maintanance_types.json
  def create
    @maintanance_type = MaintananceType.new(maintanance_type_params)

    respond_to do |format|
      if @maintanance_type.save
        format.html { redirect_to @maintanance_type, notice: 'Maintanance type was successfully created.' }
        format.json { render :show, status: :created, location: @maintanance_type }
      else
        format.html { render :new }
        format.json { render json: @maintanance_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintanance_types/1
  # PATCH/PUT /maintanance_types/1.json
  def update
    respond_to do |format|
      if @maintanance_type.update(maintanance_type_params)
        format.html { redirect_to @maintanance_type, notice: 'Maintanance type was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintanance_type }
      else
        format.html { render :edit }
        format.json { render json: @maintanance_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintanance_types/1
  # DELETE /maintanance_types/1.json
  def destroy
    @maintanance_type.destroy
    respond_to do |format|
      format.html { redirect_to maintanance_types_url, notice: 'Maintanance type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintanance_type
      @maintanance_type = MaintananceType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintanance_type_params
      params.require(:maintanance_type).permit(:name, :category_id, :required_hours_between_maintanance)
    end
end
