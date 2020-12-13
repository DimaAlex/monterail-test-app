# frozen_string_literal: true

RSpec.shared_examples 'authenticable' do |endpoint, params|
  it 'rejects request without token' do
    get endpoint, params: params

    expect(response.code).to eq '401'
  end
end
