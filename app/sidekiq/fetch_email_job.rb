class FetchEmailJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(*args)
    require 'net/http'
    require 'json'

    @emails = []
    limit = 250 
    start = 0
    loop do
      uri = URI('http://localhost:8025/api/v2/messages')
      params = { limit: limit, start: start }
      uri.query = URI.encode_www_form(params)
  
      response = Net::HTTP.get(uri)
      fetched_emails = JSON.parse(response)['items']
  
      break if fetched_emails.empty?
  
      @emails.concat(fetched_emails)
      start += limit
    end

    @emails.each do |email_data|
      process_email(email_data)
    end
  end

  private

  def process_email(email_data)
    # Define your minimum and maximum ID limits
    min_id = ENV["FROM_USER"]
    max_id = ENV["END_USER"]
    to = email_data['To'][0]
    user_email = "#{to['Mailbox']}@#{to['Domain']}"
    content = email_data['Content']['Headers']['Subject'].first
    # body = email_data['Content']['Body']

    # Find the user based on their email address
    user = User.find_by(email: user_email)

    if user && user.id.between?(min_id.to_i, max_id.to_i)
      formatted_body = "Subject: #{content}"
      user.emails.create(body: formatted_body)
      puts "Processing user with ID #{user.id}"
    else
      puts "User does not exist or is outside ID range. Skipping."
    end

  end

end
