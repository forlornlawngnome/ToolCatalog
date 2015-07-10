class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :store_location
  
  def store_location
    session[:return_to] = request.fullpath if request.get? and controller_name != "person_sessions" and controller_name != "sessions" and !request.path_info.include? "new" and !request.path_info.include? "edit"
  end
end
