require 'rails_helper'

RSpec.describe 'Application logging' do
  let(:request_method) { :get }
  let(:request_path) { '/sitemap' }

  let(:request_id) { SecureRandom.uuid }

  let(:request_headers) do
    {
      'User-Agent' => new_company_name,
      'X-Request-Id' => request_id
    }
  end

  let(:events) { [] }

  let(:results) do
    events.map do |event|
      Rails.application.config.lograge.custom_options.call(event)
    end
  end

  let(:expected_result) do
    {
      host: site.host,
      request_id: request_id,
      fwd: '127.0.0.1',
      user_id: nil,
      user_agent: "\"#{new_company_name}\""
    }
  end

  before do
    ActiveSupport::Notifications.subscribe('process_action.action_controller') do |*args|
      events << ActiveSupport::Notifications::Event.new(*args)
    end
  end

  context 'with no user' do
    it 'logs request information' do
      request_page
      expect(results).to eq([expected_result])
    end
  end

  context 'with a user' do
    let(:user) { FactoryGirl.create(:user) }

    it 'logs request information and the user id' do
      request_page
      expect(results).to eq([expected_result.merge(user_id: user.id)])
    end
  end
end
