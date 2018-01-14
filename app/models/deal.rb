class Deal
  include HTTParty

  base_uri 'https://api.pipelinedeals.com'

  KEY = ENV['PIPELINE_API_KEY']
  API_CACHE_EXPIRES = 12.hours

  class << self
    def all
      JSON.parse(fetch)['entries'].map do |deal_fields|
        new(
          value_in_cents: deal_fields['value_in_cents'],
          percent_complete: deal_fields['deal_stage']['percent'],
          stage_name: deal_fields['deal_stage']['name']
        )
      end
    end

    def fetch
      cached = Rails.cache.read 'deals-api-response'
      return cached if cached.present?

      response = get('/api/v3/deals.json', { query: { api_key: KEY } })

      if response.success?
        Rails.cache.fetch 'deals-api-response', expires_in: API_CACHE_EXPIRES do
          response.body
        end
      else
        # TODO
      end
    # rescue
    #   # TODO
    end

    def order_by_completion
      all.sort
    end

    def chart
      DealChart.new(order_by_completion).build
    end
  end

  attr_accessor :value_in_cents, :percent_complete, :stage_name

  def initialize(value_in_cents:, percent_complete:, stage_name:)
    @value_in_cents = value_in_cents
    @percent_complete = percent_complete
    @stage_name = stage_name
  end

  private

  def <=>(other_deal)
    percent_complete <=> other_deal.percent_complete
  end
end

# AVAILABLE_API_FIELDS = %i[
#   id
#   name
#   summary
#   user_id
#   created_at
#   updated_at
#   is_archived
#   is_example
#   source_id
#   primary_contact_id
#   deal_stage_id
#   probability
#   status
#   expected_close_date
#   closed_time
#   expected_close_date_event_id
#   company_id
#   import_id
#   value
#   deal_loss_reason_id
#   deal_loss_reason_notes
#   is_sample
#   revenue_type_id
#   person_ids
#   shared_user_ids
#   value_in_cents
#   date_of_first_activity
#   days_since_last_activity
#   hours_to_first_activity
#   days_in_stage
#   user
#   deal_stage
#   people
#   currency
#   deal_loss_reason
#   primary_contact
#   company
#   revenue_type
#   collaborators
#   custom_fields
# ]
