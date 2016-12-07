class AddUserIdToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
    add_index :comments, [:commentable_id, :commentable_type]

    add_column :comments, :body, :string
    add_column :comments, :user_id, :integer
    add_index :comments, :user_id
  end
end
