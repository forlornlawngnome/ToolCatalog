class ToolLogsController < ApplicationController
  before_action :set_tool_log, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_admin, only: [:create, :checkout]
  before_action :authorized_checker, :only=>[:create, :checkout]

  # GET /tool_logs
  # GET /tool_logs.json
  def index
    @tool_logs = ToolLog.all
  end

  # GET /tool_logs/1
  # GET /tool_logs/1.json
  def show
  end

  # GET /tool_logs/new
  def new
    @tool_log = ToolLog.new
  end

  # GET /tool_logs/1/edit
  def edit
  end

  # POST /tool_logs
  # POST /tool_logs.json
  def create
    if params[:multi]
      student = Person.find_by_barcode(params[:person_id].downcase)
      tool = Tool.find_by_barcode(params[:tool_id].downcase)

      if student.nil?
        redirect_to tool_login_path, alert: "No Student Exists with this ID"
      elsif tool.nil?
        redirect_to tool_login_path, alert: "No Tool Exists with this ID"
      elsif tool.checked_out
        toollog = tool.checked_out
        toollog.time_ending = Time.now
        toollog.updated_at = Time.now
        if toollog.save
          redirect_to tool_login_path, notice: "Checked In: #{tool.name}"
        else
          redirect_to tool_login_path, alert: "Failed to Checked In: #{tool.name}"
        end
      else
        if student.tools_late
          redirect_to tool_login_path, alert: "You have an overdue tool. Please return before checking out more"
        else
          toollog = ToolLog.new
          toollog.person = student
          toollog.tool = tool
          toollog.time_beginning = Time.now
          toollog.updated_at = Time.now


          if toollog.save
            redirect_to tool_login_path, notice: "Checked Out: #{tool.name}"
          else
            redirect_to tool_login_path, alert: "Failed to Check Out: #{tool.name} #{toollog.errors.full_messages}"
          end
        end

      end
    elsif params[:single]
      @toollog = Toollog.new(toollog_params)

      respond_to do |format|
        if @toollog.save
          format.html { redirect_to @toollog, notice: 'Timelog was successfully created.' }
          format.json { render json: @toollog, status: :created, location: @toollog }
        else
          format.html { render action: "new" }
          format.json { render json: @toollog.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # PATCH/PUT /tool_logs/1
  # PATCH/PUT /tool_logs/1.json
  def update
    respond_to do |format|
      if @tool_log.update(tool_log_params)
        format.html { redirect_to @tool_log, notice: 'Tool log was successfully updated.' }
        format.json { render :show, status: :ok, location: @tool_log }
      else
        format.html { render :edit }
        format.json { render json: @tool_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tool_logs/1
  # DELETE /tool_logs/1.json
  def destroy
    @tool_log.destroy
    respond_to do |format|
      format.html { redirect_to tool_logs_url, notice: 'Tool log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def checkout
    @tool_log = ToolLog.new
    @logs = ToolLog.joins(:tool).checked_out.order("tools.name")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @timelog }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool_log
      @tool_log = ToolLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_log_params
      params.require(:tool_log).permit(:tool_id, :person_id, :time_beginning, :time_ending, :duration, :tool_reservation_id)
    end
    def authorized_checker
      if current_user.is_admin or current_user.is_student_admin or current_user.email = "fablab@ncssm.edu"

      else
        redirect_to home_path, alert: "Not authorized"
      end
    end
end
