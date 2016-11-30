class AddWeightToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :weight, :integer
  end
end
