class DealChart
  attr_accessor :deals

  CURRENCY = 'USD'
  CHART_WIDTH = 1200
  CHART_HEIGHT = 600
  CHART_TITLE = 'Deals in the pipeline'
  V_AXIS_LABEL = 'Total Value (USD)'
  H_AXIS_LABEL = 'Deal Stage'

  def initialize(deals)
    @deals = deals
  end

  def build
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', H_AXIS_LABEL)
    data_table.new_column('number', V_AXIS_LABEL)
    data_table.add_rows(rows_for_chart)

    GoogleVisualr::Interactive::ColumnChart.new(data_table, chart_options)
  end

  private

  def rows_for_chart
    totals_by_stage.each_with_object([]) do |(stage, cents), rows|
      money = Money.new(cents, CURRENCY)
      rows << [stage, { v: money.dollars, f: money.format }]
    end
  end

  def totals_by_stage
    deals.each_with_object({}) do |deal, totals|
      if totals.has_key?(deal.stage_name)
        totals[deal.stage_name] += deal.value_in_cents
      else
        totals[deal.stage_name] = deal.value_in_cents
      end
    end
  end

  def chart_options
    {
      width: CHART_WIDTH,
      height: CHART_HEIGHT,
      title: CHART_TITLE,
      vAxis: {
        title: V_AXIS_LABEL
      },
      hAxis: {
        title: H_AXIS_LABEL
      }
    }
  end
end
