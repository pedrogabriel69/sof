shared_examples_for 'API create new object' do
  context 'valid params' do
    let(:request) { post "/api/v1/questions/#{valid}", access_token: access_token.token, format: :json, "#{instance}": attributes_for("#{instance}") }

    it 'returns status 201' do
      request
      expect(response.status).to eq 201
    end

    it 'creates new question' do
      expect { request }.to change(association, :count).by(1)
    end
  end

  context 'invalid params' do
    let(:request) { post "/api/v1/questions/#{valid}", access_token: access_token.token, format: :json, "#{instance}": attributes_for("#{type_instance}") }

    it 'returns status 422' do
      request
      expect(response.status).to eq 422
    end

    it "doest't creates new answer" do
      expect { request }.to_not change(association, :count)
    end
  end
end
