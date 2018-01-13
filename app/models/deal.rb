class Deal
  include HTTParty

  base_uri 'https://api.pipelinedeals.com'

  KEY = ENV['PIPELINE_API_KEY']

  class << self
    def all
      get('/api/v3/deals.json', { query: { api_key: KEY } }).response.body
    # rescue
    #   # TODO
    end
  end
end
