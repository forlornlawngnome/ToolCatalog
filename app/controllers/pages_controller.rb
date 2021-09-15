class PagesController < ApplicationController
  skip_before_action :authorize, :only=>:index
  skip_before_action :authorize_admin, :only => :index
  def index
    @hours = Hour.order(:day_of_week).group_by{|h| h.day_of_week}
    @courses_approval = CoursesPerson.where(:approved=>false).group_by{|a| a.course.name}
    @tools_maintenance = Tool.needs_action
  end
end
