require 'rails_helper'

describe 'Profile API' do
  describe 'GET/me' do
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id) }

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      it_behaves_like 'API Success'

      %w(id name email created_at updated_at admin).each do |elem|
        it "contain #{elem}" do
          expect(response.body).to be_json_eql(user.send(elem.to_sym).to_json).at_path(elem)
        end
      end

      it_behaves_like "API doesn't include password"
    end

    def do_request(options={})
      get '/api/v1/profiles/me', { format: :json }.merge(options)
    end
  end

  describe 'GET/index' do
    it_behaves_like 'API Authenticable'

    context 'all users except current' do
      let!(:user_1) { create(:user, name: 'user_1', email: 'user_1@test.io') }
      let!(:user_2) { create(:user, name: 'user_2', email: 'user_2@test.io') }
      let!(:user_3) { create(:user, name: 'user_3', email: 'user_3@test.io') }
      let(:access_token) { create(:access_token, resource_owner_id: user_1.id) }

      before { get '/api/v1/profiles', format: :json, access_token: access_token.token }

      it_behaves_like 'API Success'
      it_behaves_like "API doesn't include password"
    end

    def do_request(options={})
      get '/api/v1/profiles', { format: :json }.merge(options)
    end
  end
end
