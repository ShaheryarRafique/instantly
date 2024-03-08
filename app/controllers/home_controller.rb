class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
  end

  def email
    require 'net/http'
    require 'json'

    @emails = []
    limit = 250 # The max number you've found to be returned
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

  end

end
