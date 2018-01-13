require 'rails_helper'

RSpec.describe DealsController, type: :controller do
  include_context 'deal_api_stubs'

  describe 'GET index' do
    subject { get :index }

    it { is_expected.to be_success }
  end
end
