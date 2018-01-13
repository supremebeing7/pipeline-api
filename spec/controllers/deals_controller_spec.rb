require 'rails_helper'

RSpec.describe DealsController, type: :controller do
  describe 'GET index' do
    subject { get :index }

    it { is_expected.to be_success }
  end
end
