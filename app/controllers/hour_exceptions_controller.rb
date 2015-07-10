class HourExceptionsController < ApplicationController
  before_action :set_hour_exception, only: [:show, :edit, :update, :destroy]

  # GET /hour_exceptions
  # GET /hour_exceptions.json
  def index
    @hour_exceptions = HourException.all
  end

  # GET /hour_exceptions/1
  # GET /hour_exceptions/1.json
  def show
  end

  # GET /hour_exceptions/new
  def new
    @hour_exception = HourException.new
  end

  # GET /hour_exceptions/1/edit
  def edit
  end

  # POST /hour_exceptions
  # POST /hour_exceptions.json
  def create
    @hour_exception = HourException.new(hour_exception_params)

    respond_to do |format|
      if @hour_exception.save
        format.html { redirect_to @hour_exception, notice: 'Hour exception was successfully created.' }
        format.json { render :show, status: :created, location: @hour_exception }
      else
        format.html { render :new }
        format.json { render json: @hour_exception.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hour_exceptions/1
  # PATCH/PUT /hour_exceptions/1.json
  def update
    respond_to do |format|
      if @hour_exception.update(hour_exception_params)
        format.html { redirect_to @hour_exception, notice: 'Hour exception was successfully updated.' }
        format.json { render :show, status: :ok, location: @hour_exception }
      else
        format.html { render :edit }
        format.json { render json: @hour_exception.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hour_exceptions/1
  # DELETE /hour_exceptions/1.json
  def destroy
    @hour_exception.destroy
    respond_to do |format|
      format.html { redirect_to hour_exceptions_url, notice: 'Hour exception was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hour_exception
      @hour_exception = HourException.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hour_exception_params
      params.require(:hour_exception).permit(:time_beginning, :time_ending, :person_id)
    end
end
