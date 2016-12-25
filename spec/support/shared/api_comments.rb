shared_examples_for 'API comments' do
  context 'comment' do
    it 'included in question object' do
      expect(response.body).to have_json_size(1).at_path("comments")
    end

    %w(id body created_at updated_at commentable_id commentable_type).each do |elem|
      it "comment object contains #{elem}" do
        expect(response.body).to be_json_eql(comment.send(elem.to_sym).to_json).at_path("comments/0/#{elem}")
      end
    end
  end
end
