require 'rails_helper'

RSpec.describe DealChart, type: :model do
  let(:deals) do
    [
      Deal.new(
        value_in_cents: 4000,
        percent_complete: 50,
        stage_name: 'Proposal'
      ),
      Deal.new(
        value_in_cents: 2000,
        percent_complete: 50,
        stage_name: 'Proposal'
      ),
      Deal.new(
        value_in_cents: 7500,
        percent_complete: 100,
        stage_name: 'Won'
      ),
      Deal.new(
        value_in_cents: 2500,
        percent_complete: 100,
        stage_name: 'Won'
      )
    ]
  end

  subject(:deal_chart) { described_class.new(deals) }

  it { is_expected.to respond_to :deals }

  describe '#build' do
    it 'returns a column chart' do
      expect(deal_chart.build).to be_a GoogleVisualr::Interactive::ColumnChart
    end

    it 'has the correct title and axis labels' do
      expect(deal_chart.build.options['title']).to eq 'Deals in the pipeline'
      expect(deal_chart.build.options['hAxis'][:title]).to eq 'Deal Stage'
      expect(deal_chart.build.options['vAxis'][:title]).to eq 'Total Value'
    end

    it 'has the correct first column' do
      first_column = deal_chart.build.data_table.rows.first
      expect(first_column.first.v).to eq 'Proposal'
      expect(first_column.last.f).to eq '$60.00'
      expect(first_column.last.v).to eq 60
    end

    it 'has the correct second column' do
      second_column = deal_chart.build.data_table.rows.second
      expect(second_column.first.v).to eq 'Won'
      expect(second_column.last.f).to eq '$100.00'
      expect(second_column.last.v).to eq 100
    end
  end
  # def build_chart
  #   data_table = GoogleVisualr::DataTable.new
  #   data_table.new_column('string', 'Deal Stage')
  #   data_table.new_column('number', 'Sales Value')
  #   data_table.add_rows(rows_for_chart)
  #
  #   GoogleVisualr::Interactive::ColumnChart.new(data_table, chart_options)
  # end
end
