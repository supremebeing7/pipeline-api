RSpec.shared_context 'deal_api_stubs' do
  let(:body) { "abc" }
  let(:api_key) { ENV['PIPELINE_API_KEY'] }

  before do
    stub_request(:get, "https://api.pipelinedeals.com/api/v3/deals.json").
      with(query: { "api_key" => api_key }).
      to_return(body: body)
  end
end
