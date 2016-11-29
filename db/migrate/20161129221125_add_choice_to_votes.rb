class AddChoiceToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :choice, :boolean
  end
end
