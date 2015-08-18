class PagesController < ApplicationController
  skip_before_filter :authorize, :only=>:index
  def index
    @hours = Hour.order(:day_of_week).group_by{|h| h.day_of_week}
    @courses_approval = CoursesPerson.where(:approved=>false, :approved=>nil).group_by{|a| a.course.name}
    @tools_maintenance = Tool.needs_action
  end
end