module ApplicationHelper
  def redirect_back_or_default
    redirect_to(session[:return_to] || home_path)
  end
  def back_link
    session[:return_to] || home_path
  end
  def self.today
  
    #If it's before midnight...
    if Time.now.in_time_zone(ApplicationHelper.TimeZone) < Time.now.in_time_zone(ApplicationHelper.TimeZone).beginning_of_day + DAY_END.hours
      #then pretend it's still yesterday to give kids time to sign out
      Time.now.in_time_zone(ApplicationHelper.TimeZone).beginning_of_day - 1.days
    else
      Time.now.in_time_zone(ApplicationHelper.TimeZone).beginning_of_day
    end
  end
  def self.TimeZone
    TIMEZONE
  end
  def self.zone
    zone = ActiveSupport::TimeZone.new(ApplicationHelper.TimeZone)
  end
end
