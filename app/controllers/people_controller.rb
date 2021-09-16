class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, :only => [:new, :create]
  skip_before_action :authorize_admin, :only => [:new, :create, :edit, :update]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    first = false
    if Person.all.size < 1
      first = true
    end
    @person = Person.new(person_params)
    if first
      @person.is_admin = true
    end
    respond_to do |format|
      if @person.save
        if !current_user
          session[:person_id] = @person.id
        end
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
  def reset_userkeys

    #not_admins = Person.where.not(is_admin: true)#.or(Person.where(is_admin: nil))
    not_admins = Person.where("is_admin is not true or is_admin is null")
    year = 0
    if Date.current.month > 5
      year = Date.current.year + 1
    else
      year = Date.current.year
    end

    people = not_admins.where("graduation_year <= ?",year)
    people = people.where("updated_at < ?", Date.current - 1.month)
    people.each do |person|
      if person.barcode != person.email
        person.barcode = person.email
        person.save
      end
      if !person.archived and person.graduation_year < year
        person.archived = true
        person.save
      end
    end
    redirect_to admin_current_students_path
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :email, :graduation_year, :barcode, :emergency_contact_name, :emergency_contact_number, :archived, :is_admin, :is_student_admin, :password, :password_confirmation, :password_reset_token, :course_ids=>[])
    end
end
