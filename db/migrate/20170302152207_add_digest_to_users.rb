class AddDigestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :digest, :boolean, default: true, null: false
  end
end
