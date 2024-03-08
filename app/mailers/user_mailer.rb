class UserMailer < ApplicationMailer

    def welcome_mail
        @name = params[:name]
        @email = params[:email]
        mail(to: @email, subject: "Welcome to Our Application, #{@name}")
    end

end
