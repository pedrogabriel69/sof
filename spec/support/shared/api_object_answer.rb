shared_examples_for 'API answer include' do
  %w(id body created_at updated_at question_id).each do |elem|
    it "answer object contains #{elem}" do
      expect(response.body).to be_json_eql(answer.send(elem.to_sym).to_json).at_path("#{add_path}#{elem}")
    end
  end
end
