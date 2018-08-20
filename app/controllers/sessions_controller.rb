class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new  
  end  
  def create  
    user = Person.find_by_email(params[:signin][:email])  
    if user && user.authenticate(params[:signin][:password])  
      session[:person_id] = user.id  
      redirect_to home_path, :notice => "Logged in!"  
    else  
      flash.now.alert = "Invalid email or password"  
      render "new"  
    end  
  end  
  
  def destroy  
    session[:person_id] = nil  
    redirect_to home_path, :notice => "Logged out!"  
  end
end
