class FormsPeopleController < ApplicationController
  before_action :set_forms_person, only: [:show, :edit, :update, :destroy]

  # GET /forms_people
  # GET /forms_people.json
  def index
    @forms_people = FormsPerson.all
  end

  # GET /forms_people/1
  # GET /forms_people/1.json
  def show
  end

  # GET /forms_people/new
  def new
    @forms_person = FormsPerson.new
  end

  # GET /forms_people/1/edit
  def edit
  end

  # POST /forms_people
  # POST /forms_people.json
  def create
    @forms_person = FormsPerson.new(forms_person_params)

    respond_to do |format|
      if @forms_person.save
        format.html { redirect_to @forms_person, notice: 'Forms person was successfully created.' }
        format.json { render :show, status: :created, location: @forms_person }
      else
        format.html { render :new }
        format.json { render json: @forms_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forms_people/1
  # PATCH/PUT /forms_people/1.json
  def update
    respond_to do |format|
      if @forms_person.update(forms_person_params)
        format.html { redirect_to @forms_person, notice: 'Forms person was successfully updated.' }
        format.json { render :show, status: :ok, location: @forms_person }
      else
        format.html { render :edit }
        format.json { render json: @forms_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forms_people/1
  # DELETE /forms_people/1.json
  def destroy
    @forms_person.destroy
    respond_to do |format|
      format.html { redirect_to forms_people_url, notice: 'Forms person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forms_person
      @forms_person = FormsPerson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forms_person_params
      params.require(:forms_person).permit(:person_id, :form_id)
    end
end
