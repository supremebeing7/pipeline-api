RSpec.shared_context 'deal_api_stubs' do
  let(:body) do
    {
      'entries' => [{
        "value_in_cents"=>100,
        "deal_stage"=>{"id"=>12345, "percent"=>50, "name"=>"Presentation"},
      },
      {
        "value_in_cents"=>200,
        "deal_stage"=>{"id"=>12346, "percent"=>0, "name"=>"Lost"},
      },
      {
        "value_in_cents"=>300,
        "deal_stage"=>{"id"=>12347, "percent"=>100, "name"=>"Won"},
      }]
    }.to_json
  end
  let(:api_key) { ENV['PIPELINE_API_KEY'] }

  before do
    stub_request(:get, "https://api.pipelinedeals.com/api/v3/deals.json").
      with(query: { "api_key" => api_key }).
      to_return(body: body)
  end
end
