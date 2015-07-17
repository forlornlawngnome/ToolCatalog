class PersonMailer < ActionMailer::Base
  default from: "password_reset@team900.org"

    def password_reset(user)
      @user = user
      mail :to => user.email, :subject => "Password Reset"
    end
end
