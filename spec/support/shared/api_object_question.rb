shared_examples_for 'API question include' do
  %w(id title body created_at updated_at).each do |elem|
    it "question object contains #{elem}" do
      expect(response.body).to be_json_eql(question.send(elem.to_sym).to_json).at_path("#{add_path_question}#{elem}")
    end
  end
end
