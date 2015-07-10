class CoursesPeopleController < ApplicationController
  before_action :set_courses_person, only: [:show, :edit, :update, :destroy]

  # GET /courses_people
  # GET /courses_people.json
  def index
    @courses_people = CoursesPerson.all
  end

  # GET /courses_people/1
  # GET /courses_people/1.json
  def show
  end

  # GET /courses_people/new
  def new
    @courses_person = CoursesPerson.new
  end

  # GET /courses_people/1/edit
  def edit
  end

  # POST /courses_people
  # POST /courses_people.json
  def create
    @courses_person = CoursesPerson.new(courses_person_params)

    respond_to do |format|
      if @courses_person.save
        format.html { redirect_to @courses_person.course, notice: 'Courses/person was successfully created.' }
        format.json { render :show, status: :created, location: @courses_person }
      else
        format.html { render :new }
        format.json { render json: @courses_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses_people/1
  # PATCH/PUT /courses_people/1.json
  def update
    respond_to do |format|
      if @courses_person.update(courses_person_params)
        format.html { redirect_to @courses_person, notice: 'Courses person was successfully updated.' }
        format.json { render :show, status: :ok, location: @courses_person }
      else
        format.html { render :edit }
        format.json { render json: @courses_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses_people/1
  # DELETE /courses_people/1.json
  def destroy
    @courses_person.destroy
    respond_to do |format|
      format.html { redirect_to courses_people_url, notice: 'Courses person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_courses_person
      @courses_person = CoursesPerson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def courses_person_params
      params.require(:courses_person).permit(:course_id, :person_id, :date_requested, :approver, :approved, :approval_date)
    end
end
