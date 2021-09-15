class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize
  before_action :authorize_admin, :only=>[:edit, :update, :new, :create]
  after_action :store_location

  def store_location
    session[:return_to] = request.fullpath if request.get? and controller_name != "person_sessions" and controller_name != "sessions" and !request.path_info.include? "new" and !request.path_info.include? "edit"
  end

  private
    def current_user
      @current_user ||= Person.find(session[:person_id]) if session[:person_id]
    end
    def authorize
      redirect_to login_url, alert: "Not authorized" if current_user.nil?
    end
    def authorize_admin
      if current_user.is_admin or current_user.is_student_admin

      else
        redirect_to home_path, alert: "Not authorized"
      end
    end
    helper_method :current_user
end
