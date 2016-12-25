shared_examples_for 'API List' do
  it "return list" do
    expect(response.body).to have_json_size(2)
  end
end
