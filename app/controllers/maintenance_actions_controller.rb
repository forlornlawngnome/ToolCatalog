class MaintenanceActionsController < ApplicationController
  before_action :set_maintenance_action, only: [:show, :edit, :update, :destroy]

  # GET /maintenance_actions
  # GET /maintenance_actions.json
  def index
    @maintenance_actions = MaintenanceAction.all
  end

  # GET /maintenance_actions/1
  # GET /maintenance_actions/1.json
  def show
  end

  # GET /maintenance_actions/new
  def new
    @maintenance_action = MaintenanceAction.new
  end

  # GET /maintenance_actions/1/edit
  def edit
  end

  # POST /maintenance_actions
  # POST /maintenance_actions.json
  def create
    @maintenance_action = MaintenanceAction.new(maintenance_action_params)

    respond_to do |format|
      if @maintenance_action.save
        format.html { redirect_to @maintenance_action, notice: 'Maintenance action was successfully created.' }
        format.json { render :show, status: :created, location: @maintenance_action }
      else
        format.html { render :new }
        format.json { render json: @maintenance_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenance_actions/1
  # PATCH/PUT /maintenance_actions/1.json
  def update
    respond_to do |format|
      if @maintenance_action.update(maintenance_action_params)
        format.html { redirect_to @maintenance_action, notice: 'Maintenance action was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintenance_action }
      else
        format.html { render :edit }
        format.json { render json: @maintenance_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_actions/1
  # DELETE /maintenance_actions/1.json
  def destroy
    @maintenance_action.destroy
    respond_to do |format|
      format.html { redirect_to maintenance_actions_url, notice: 'Maintenance action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_action
      @maintenance_action = MaintenanceAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintenance_action_params
      params.require(:maintenance_action).permit(:date, :tool_id, :person_id, :maintenance_type_id)
    end
end
