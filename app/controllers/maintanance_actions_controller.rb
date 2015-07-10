class MaintananceActionsController < ApplicationController
  before_action :set_maintanance_action, only: [:show, :edit, :update, :destroy]

  # GET /maintanance_actions
  # GET /maintanance_actions.json
  def index
    @maintanance_actions = MaintananceAction.all
  end

  # GET /maintanance_actions/1
  # GET /maintanance_actions/1.json
  def show
  end

  # GET /maintanance_actions/new
  def new
    @maintanance_action = MaintananceAction.new
  end

  # GET /maintanance_actions/1/edit
  def edit
  end

  # POST /maintanance_actions
  # POST /maintanance_actions.json
  def create
    @maintanance_action = MaintananceAction.new(maintanance_action_params)

    respond_to do |format|
      if @maintanance_action.save
        format.html { redirect_to @maintanance_action, notice: 'Maintanance action was successfully created.' }
        format.json { render :show, status: :created, location: @maintanance_action }
      else
        format.html { render :new }
        format.json { render json: @maintanance_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintanance_actions/1
  # PATCH/PUT /maintanance_actions/1.json
  def update
    respond_to do |format|
      if @maintanance_action.update(maintanance_action_params)
        format.html { redirect_to @maintanance_action, notice: 'Maintanance action was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintanance_action }
      else
        format.html { render :edit }
        format.json { render json: @maintanance_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintanance_actions/1
  # DELETE /maintanance_actions/1.json
  def destroy
    @maintanance_action.destroy
    respond_to do |format|
      format.html { redirect_to maintanance_actions_url, notice: 'Maintanance action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintanance_action
      @maintanance_action = MaintananceAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintanance_action_params
      params.require(:maintanance_action).permit(:date, :tool_id, :person_id, :maintanance_type_id)
    end
end
