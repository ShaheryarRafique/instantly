require 'sidekiq/cron/job'

Sidekiq::Cron::Job.create(
  name: 'My Fetch Email Job - every 2 hours',
  cron: '* */2 * * *',
  class: 'FetchEmailJob'
)
