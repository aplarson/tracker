class AddPrivacyToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :privacy, :boolean, null: false, default: false
  end
end
