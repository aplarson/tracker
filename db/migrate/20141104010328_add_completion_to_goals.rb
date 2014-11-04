class AddCompletionToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :completion, :boolean, null: false, default: false
  end
end
