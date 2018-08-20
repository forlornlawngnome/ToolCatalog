class ToolImportController < ApplicationController
  def new
    respond_to do |format|
      format.html
      format.csv { send_data (ToolImport.new).generate_csv, :filename =>"tools.csv" }
    end
  end

  def create
    @tool_import = nil
    @tool_import = ToolImport.import(params[:tool_import])
    if @tool_import == true
      redirect_to admin_tool_import_path, notice: "Imported tools successfully."
    else
      render  :new
    end
  end
end