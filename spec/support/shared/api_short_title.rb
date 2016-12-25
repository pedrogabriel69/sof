shared_examples_for 'API question short title' do
  it 'question object contains short title' do
    expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("#{add_path_question}short_title")
  end
end
