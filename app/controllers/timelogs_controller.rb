class TimelogsController < ApplicationController
  before_action :set_timelog, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_admin, only: [:create, :student]
  before_action :authorized_checker, :only=>[:create, :student]

  # GET /timelogs
  # GET /timelogs.json
  def index
    @timelogs = Timelog.all
  end

  # GET /timelogs/1
  # GET /timelogs/1.json
  def show
  end

  # GET /timelogs/new
  def new
    @timelog = Timelog.new
  end

  # GET /timelogs/1/edit
  def edit
  end

  # POST /timelogs
  # POST /timelogs.json
  def create
    if params[:multi]
      student = Person.find_by_barcode(params[:person_id].downcase)
      if student.nil?
        redirect_to lab_login_path, alert: "No Student Exists with this ID"
      elsif student.signed_in
        timelog = student.signed_in
        timelog.time_ending = Time.now
        timelog.updated_at = Time.now
        if timelog.save
          redirect_to lab_login_path, notice: "Signed Out: #{student.name}"
        else
          redirect_to lab_login_path, alert: "Failed to Sign Out: #{student.name}"
        end
      else
        timelog = Timelog.new
        timelog.person = student
        timelog.time_beginning = Time.now
        timelog.updated_at = Time.now

        student.archived=false
        if !student.save
          redirect_to lab_login_path, alert: "Failed to Sign In: #{student.name}"
        end

        if timelog.save
          redirect_to lab_login_path, notice: "Signed In: #{student.name}"
        else
          redirect_to lab_login_path, alert: "Failed to Sign In: #{student.name}"
        end

      end
    elsif params[:single]
      @timelog = Timelog.new(timelog_params)

      respond_to do |format|
        if @timelog.save
          format.html { redirect_to @timelog, notice: 'Timelog was successfully created.' }
          format.json { render json: @timelog, status: :created, location: @timelog }
        else
          format.html { render action: "new" }
          format.json { render json: @timelog.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /timelogs/1
  # PATCH/PUT /timelogs/1.json
  def update
    respond_to do |format|
      if @timelog.update(timelog_params)
        format.html { redirect_to @timelog, notice: 'Timelog was successfully updated.' }
        format.json { render :show, status: :ok, location: @timelog }
      else
        format.html { render :edit }
        format.json { render json: @timelog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timelogs/1
  # DELETE /timelogs/1.json
  def destroy
    @timelog.destroy
    respond_to do |format|
      format.html { redirect_to timelogs_url, notice: 'Timelog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def student
    @timelog = Timelog.new
    @logs = Timelog.today.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @timelog }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timelog
      @timelog = Timelog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timelog_params
      params.require(:timelog).permit(:person_id, :time_beginning, :time_ending, :duration)
    end
    def authorized_checker
      if current_user.is_admin or current_user.is_student_admin or current_user.email = "fablab@ncssm.edu"

      else
        redirect_to home_path, alert: "Not authorized"
      end
    end
end
