class AddUserIdToAuthorizations < ActiveRecord::Migration[5.0]
  def change
    add_column :authorizations, :user_id, :integer
    add_index :authorizations, :user_id
    add_index :authorizations, [:provider, :uid]
  end
end
