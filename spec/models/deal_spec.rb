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
end
