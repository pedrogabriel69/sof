class AddQuestionIdAttachment < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :question_id, :integer
    add_index :attachments, :question_id
  end
end