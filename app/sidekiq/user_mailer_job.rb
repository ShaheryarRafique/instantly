# require 'sidekiq/cron/worker'

class UserMailerJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform
    User.find_each do |user|
      UserMailer.with(email: user.email, name: user.name).welcome_mail.deliver_later 
    end
  end
end

# Sidekiq::Cron::Job.create(name: 'Send User Mail - every 30 sec', cron: '* * * * *', class: 'UserMailerJob') 
