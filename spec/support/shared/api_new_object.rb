shared_examples_for 'API create new object' do
  context 'valid params' do
    let(:subject) { post "/api/v1/questions/#{valid}", access_token: access_token.token, format: :json, "#{instance}": attributes_for("#{instance}") }

    it 'returns status 201' do
      subject
      expect(response.status).to eq 201
    end

    it 'creates new question' do
      expect { subject }.to change(association, :count).by(1)
    end
  end

  context 'invalid params' do
    let(:subject) { post "/api/v1/questions/#{valid}", access_token: access_token.token, format: :json, "#{instance}": attributes_for("#{type_instance}") }

    it 'returns status 422' do
      subject
      expect(response.status).to eq 422
    end

    it "doest't creates new answer" do
      expect { subject }.to_not change(association, :count)
    end
  end
end
