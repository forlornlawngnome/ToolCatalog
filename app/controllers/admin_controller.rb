class AdminController < ApplicationController
  def students
    @people = Person.active
  end
  def admin_console
    @tools_maintanance = Tool.needs_action
    @categories = Category.order(:name)
  end
  def tools_out
    
  end
  def forms
    @forms = Form.order("name")
    @users = Person.active.order("name")
  end
  def course_approval
  end
end