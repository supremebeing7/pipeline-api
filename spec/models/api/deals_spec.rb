require 'rails_helper'

RSpec.describe API::Deals, type: :model do
  include_context 'deal_api_stubs'

  describe '.fetch' do
    it 'fetches deals' do
      expect(described_class.fetch).to eq body
    end
  end
end
