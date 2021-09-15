class SpaceReservationsController < ApplicationController
  before_action :set_space_reservation, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_admin, :only => [:new, :create]

  # GET /space_reservations
  # GET /space_reservations.json
  def index
    @space_reservations = SpaceReservation.all
  end

  # GET /space_reservations/1
  # GET /space_reservations/1.json
  def show
  end

  # GET /space_reservations/new
  def new
    @space_reservation = SpaceReservation.new
  end

  # GET /space_reservations/1/edit
  def edit
  end

  # POST /space_reservations
  # POST /space_reservations.json
  def create
    @space_reservation = SpaceReservation.new(space_reservation_params)

    respond_to do |format|
      if @space_reservation.save
        format.html { redirect_to @space_reservation, notice: 'Space reservation was successfully created.' }
        format.json { render :show, status: :created, location: @space_reservation }
      else
        format.html { render :new }
        format.json { render json: @space_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /space_reservations/1
  # PATCH/PUT /space_reservations/1.json
  def update
    respond_to do |format|
      if @space_reservation.update(space_reservation_params)
        format.html { redirect_to @space_reservation, notice: 'Space reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @space_reservation }
      else
        format.html { render :edit }
        format.json { render json: @space_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /space_reservations/1
  # DELETE /space_reservations/1.json
  def destroy
    @space_reservation.destroy
    respond_to do |format|
      format.html { redirect_to space_reservations_url, notice: 'Space reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space_reservation
      @space_reservation = SpaceReservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_reservation_params
      params.require(:space_reservation).permit(:person_id, :space_id, :reservation_beginning, :reservation_ending, :number_of_people)
    end
end
