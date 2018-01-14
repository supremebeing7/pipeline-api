class Deal
  class << self
    def all
      response = API::Deals.fetch

      return [] unless response.present?

      JSON.parse(response)['entries'].map do |deal_fields|
        new(
          value_in_cents: deal_fields['value_in_cents'],
          percent_complete: deal_fields['deal_stage']['percent'],
          stage_name: deal_fields['deal_stage']['name']
        )
      end
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

  # This should be doable via the API, but that's not working
  def <=>(other_deal)
    percent_complete <=> other_deal.percent_complete
  end
end
