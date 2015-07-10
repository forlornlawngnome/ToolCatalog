class DocumentationLinksController < ApplicationController
  before_action :set_documentation_link, only: [:show, :edit, :update, :destroy]

  # GET /documentation_links
  # GET /documentation_links.json
  def index
    @documentation_links = DocumentationLink.all
  end

  # GET /documentation_links/1
  # GET /documentation_links/1.json
  def show
  end

  # GET /documentation_links/new
  def new
    @documentation_link = DocumentationLink.new
  end

  # GET /documentation_links/1/edit
  def edit
  end

  # POST /documentation_links
  # POST /documentation_links.json
  def create
    @documentation_link = DocumentationLink.new(documentation_link_params)

    respond_to do |format|
      if @documentation_link.save
        format.html { redirect_to @documentation_link, notice: 'Documentation link was successfully created.' }
        format.json { render :show, status: :created, location: @documentation_link }
      else
        format.html { render :new }
        format.json { render json: @documentation_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documentation_links/1
  # PATCH/PUT /documentation_links/1.json
  def update
    respond_to do |format|
      if @documentation_link.update(documentation_link_params)
        format.html { redirect_to @documentation_link, notice: 'Documentation link was successfully updated.' }
        format.json { render :show, status: :ok, location: @documentation_link }
      else
        format.html { render :edit }
        format.json { render json: @documentation_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentation_links/1
  # DELETE /documentation_links/1.json
  def destroy
    @documentation_link.destroy
    respond_to do |format|
      format.html { redirect_to documentation_links_url, notice: 'Documentation link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documentation_link
      @documentation_link = DocumentationLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def documentation_link_params
      params.require(:documentation_link).permit(:name, :link, :course_id, :active)
    end
end
