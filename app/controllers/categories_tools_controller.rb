class CategoriesToolsController < ApplicationController
  before_action :set_categories_tool, only: [:show, :edit, :update, :destroy]

  # GET /categories_tools
  # GET /categories_tools.json
  def index
    @categories_tools = CategoriesTool.all
  end

  # GET /categories_tools/1
  # GET /categories_tools/1.json
  def show
  end

  # GET /categories_tools/new
  def new
    @categories_tool = CategoriesTool.new
  end

  # GET /categories_tools/1/edit
  def edit
  end

  # POST /categories_tools
  # POST /categories_tools.json
  def create
    @categories_tool = CategoriesTool.new(categories_tool_params)

    respond_to do |format|
      if @categories_tool.save
        format.html { redirect_to @categories_tool, notice: 'Categories tool was successfully created.' }
        format.json { render :show, status: :created, location: @categories_tool }
      else
        format.html { render :new }
        format.json { render json: @categories_tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories_tools/1
  # PATCH/PUT /categories_tools/1.json
  def update
    respond_to do |format|
      if @categories_tool.update(categories_tool_params)
        format.html { redirect_to @categories_tool, notice: 'Categories tool was successfully updated.' }
        format.json { render :show, status: :ok, location: @categories_tool }
      else
        format.html { render :edit }
        format.json { render json: @categories_tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories_tools/1
  # DELETE /categories_tools/1.json
  def destroy
    @categories_tool.destroy
    respond_to do |format|
      format.html { redirect_to categories_tools_url, notice: 'Categories tool was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categories_tool
      @categories_tool = CategoriesTool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categories_tool_params
      params.require(:categories_tool).permit(:tool_id, :category_id)
    end
end
