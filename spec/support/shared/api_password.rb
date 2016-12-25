shared_examples_for "API doesn't include password" do
  %w(password encrypted_password).each do |elem|
    it "doesn't include #{elem}" do
      expect(response.body).to_not have_json_path(elem)
    end
  end
end
