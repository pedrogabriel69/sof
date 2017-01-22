class AddCheckFollowToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :check_follow, :boolean, default: true, null: false
  end
end
