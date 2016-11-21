class AddFlagToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :flag, :boolean, default: false, null: false
  end
end
