require 'rails_helper'

RSpec.describe Deal, type: :model do
  include_context 'deal_api_stubs'

  describe '.fetch' do
    it 'fetches deals' do
      expect(described_class.fetch).to eq body
    end
  end

  describe '.all' do
    it 'is a collection' do
      expect(described_class.all).to be_an Array
    end

    it 'contains Deals' do
      expect(described_class.all).to all( be_a(Deal) )
    end
  end

  subject(:deal) do
    described_class.new(
      value_in_cents: 876_54,
      percent_complete: 75,
      stage_name: 'Presentation'
    )
  end

  it { is_expected.to respond_to :value_in_cents }
  it { is_expected.to respond_to :percent_complete }
  it { is_expected.to respond_to :stage_name }

  describe '.order_by_completion' do
    let(:not_done_deal) do
      described_class.new(
        value_in_cents: 123,
        percent_complete: 50,
        stage_name: 'Not Done'
      )
    end
    let(:done_deal) do
      described_class.new(
        value_in_cents: 321,
        percent_complete: 100,
        stage_name: 'Done'
      )
    end

    before do
      allow(described_class).to receive(:all).and_return(
        [done_deal, not_done_deal]
      )
    end

    it 'sorts by percent_complete' do
      expect(described_class.order_by_completion).to eq(
        [not_done_deal, done_deal]
      )
    end
  end
end
