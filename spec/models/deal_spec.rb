require 'rails_helper'

RSpec.describe Deal, type: :model do
  include_context 'deal_api_stubs'

  describe '.all' do
    it 'fetches deals' do
      expect(described_class.all).to eq body
    end
  end
end
