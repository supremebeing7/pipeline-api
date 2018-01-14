module API
  class Deals
    include HTTParty

    base_uri 'https://api.pipelinedeals.com'

    KEY = ENV['PIPELINE_API_KEY']
    SORT_KEY = 'deals.percentage'

    # Caching the API request to avoid hitting the API continuously in dev.
    # The actual request takes ~1s so can probably be done synchronously
    API_CACHE_EXPIRES = 2.hours

    class << self
      def fetch
        cached = Rails.cache.read 'deals-api-response'

        return cached if cached.present?

        response = get('/api/v3/deals.json', { query: query_params })

        if response.success?
          Rails.cache.fetch 'deals-api-response', expires_in: API_CACHE_EXPIRES do
            response.body
          end
        end
      rescue
        nil # Handle this in calling method
      end

      def query_params
        {
          api_key: KEY,
          # This is giving 500 errors... I _think_ I have the syntax correct
          # Ref: https://app.pipelinedeals.com/api/docs/resources/deals
          # sort: SORT_KEY
        }
      end
    end
  end
end
