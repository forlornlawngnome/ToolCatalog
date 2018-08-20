class PasswordResetsController < ApplicationController
  def new
  end
  def create
    user = Person.find_by_email(params[:password_reset][:email])
    user.send_password_reset if user
    redirect_to home_path, :notice => "Email sent with password reset instructions. Please check your spam filter if you can't find the email."
  end
  def edit
    @user = Person.find_by_password_reset_token!(params[:id])
  end
  def update
    @user = Person.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password &crarr; 
        reset has expired."
    elsif @user.update_attributes(params.permit![:person])
      redirect_to home_path, :notice => "Password has been reset."
    else
      render :edit
    end
  end
end
