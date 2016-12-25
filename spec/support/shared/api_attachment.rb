shared_examples_for 'API attachment' do
  context 'attachment' do
    it 'included in object' do
      expect(response.body).to have_json_size(1).at_path("attachments")
    end

    %w(id attachmentable_id attachmentable_type).each do |elem|
      it "attachment object contains #{elem}" do
        expect(response.body).to be_json_eql(attachment.send(elem.to_sym).to_json).at_path("attachments/0/#{elem}")
      end
    end

    it 'attachment object contains url' do
      expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("attachments/0/url")
    end
  end
end
