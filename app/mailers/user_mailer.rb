class UserMailer < ApplicationMailer
    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: 'Welcome to Pokemon Battle')
    end
end