class MailerJob
  include Sidekiq::Job

  def perform(user_id)
    # Do something
    user = User.find_by(id: user_id)
    UserMailer.welcome_email(user).deliver_now
  end
end
