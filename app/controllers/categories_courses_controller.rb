class CategoriesCoursesController < ApplicationController
  before_action :set_categories_course, only: [:show, :edit, :update, :destroy]

  # GET /categories_courses
  # GET /categories_courses.json
  def index
    @categories_courses = CategoriesCourse.all
  end

  # GET /categories_courses/1
  # GET /categories_courses/1.json
  def show
  end

  # GET /categories_courses/new
  def new
    @categories_course = CategoriesCourse.new
  end

  # GET /categories_courses/1/edit
  def edit
  end

  # POST /categories_courses
  # POST /categories_courses.json
  def create
    @categories_course = CategoriesCourse.new(categories_course_params)

    respond_to do |format|
      if @categories_course.save
        format.html { redirect_to @categories_course, notice: 'Categories course was successfully created.' }
        format.json { render :show, status: :created, location: @categories_course }
      else
        format.html { render :new }
        format.json { render json: @categories_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories_courses/1
  # PATCH/PUT /categories_courses/1.json
  def update
    respond_to do |format|
      if @categories_course.update(categories_course_params)
        format.html { redirect_to @categories_course, notice: 'Categories course was successfully updated.' }
        format.json { render :show, status: :ok, location: @categories_course }
      else
        format.html { render :edit }
        format.json { render json: @categories_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories_courses/1
  # DELETE /categories_courses/1.json
  def destroy
    @categories_course.destroy
    respond_to do |format|
      format.html { redirect_to categories_courses_url, notice: 'Categories course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categories_course
      @categories_course = CategoriesCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categories_course_params
      params.require(:categories_course).permit(:category_id, :course_id)
    end
end
