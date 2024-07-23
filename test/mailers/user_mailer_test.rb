# require "test_helper"
class UserMailer < ApplicationMailer
  default from: 'akshat.sharma@webkorps.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://spotify.com/login'
    mail(to: @user.email, subject: 'Welcome to our spotify')
  end
end
