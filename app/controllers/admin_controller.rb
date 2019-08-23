class AdminController < ApplicationController
  def students
    @people = Person.active
  end
  def admin_console
    @tools_maintenance = Tool.needs_action
    @categories = Category.order(:name)
  end
  def tools_out
    @tools_out = ToolLog.checked_out
  end

  def course_approval
    @courses_people = CoursesPerson.not_approved.includes(:course).order("courses.name")
  end
end