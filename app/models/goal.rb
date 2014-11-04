# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :text             not null
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#  privacy     :boolean          default(FALSE), not null
#  completion  :boolean          default(FALSE), not null
#

class Goal < ActiveRecord::Base
  validates :title, :description, :user, presence: true
  validates :privacy, :completion, inclusion: { in: [true, false, nil] }
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :comments,
    class_name: "GoalComment",
    foreign_key: :goal_id,
    primary_key: :id
  )
end
