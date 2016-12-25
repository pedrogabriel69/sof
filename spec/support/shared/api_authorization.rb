shared_examples_for 'API Authenticable' do
  context 'unauthorized' do
    it "returns 401 status if access token doesn't exist" do
      do_request
      expect(response.status).to eq 401
    end

    it "returns 401 status if access token is invalid" do
      do_request(access_token: '1234')
      expect(response.status).to eq 401
    end
  end
end
