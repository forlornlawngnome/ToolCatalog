class ToolReservationsController < ApplicationController
  before_action :set_tool_reservation, only: [:show, :edit, :update, :destroy]
   skip_before_filter :authorize_admin, :only => [:new, :create]

  # GET /tool_reservations
  # GET /tool_reservations.json
  def index
    @tool_reservations = ToolReservation.all
  end
  
  def calendar
    @tool_reservations = ToolReservation.all
    @reservations_by_date = @tool_reservations.group_by{|a| a.reservation_beginning.strftime("%Y-%m-%d")}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  # GET /tool_reservations/1
  # GET /tool_reservations/1.json
  def show
  end

  # GET /tool_reservations/new
  def new
    @tool_reservation = ToolReservation.new
  end

  # GET /tool_reservations/1/edit
  def edit
  end

  # POST /tool_reservations
  # POST /tool_reservations.json
  def create
    @tool_reservation = ToolReservation.new(tool_reservation_params)

    respond_to do |format|
      if @tool_reservation.save
        format.html { redirect_to @tool_reservation, notice: 'Tool reservation was successfully created.' }
        format.json { render :show, status: :created, location: @tool_reservation }
      else
        format.html { render :new }
        format.json { render json: @tool_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tool_reservations/1
  # PATCH/PUT /tool_reservations/1.json
  def update
    respond_to do |format|
      if @tool_reservation.update(tool_reservation_params)
        format.html { redirect_to @tool_reservation, notice: 'Tool reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @tool_reservation }
      else
        format.html { render :edit }
        format.json { render json: @tool_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tool_reservations/1
  # DELETE /tool_reservations/1.json
  def destroy
    @tool_reservation.destroy
    respond_to do |format|
      format.html { redirect_to tool_reservations_url, notice: 'Tool reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool_reservation
      @tool_reservation = ToolReservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_reservation_params
      params.require(:tool_reservation).permit(:person_id, :tool_id, :reservation_beginning, :reservation_ending)
    end
end
