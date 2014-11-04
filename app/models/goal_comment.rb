# == Schema Information
#
# Table name: goal_comments
#
#  id         :integer          not null, primary key
#  author_id  :integer          not null
#  goal_id    :integer          not null
#  body       :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class GoalComment < ActiveRecord::Base
  validates :author, :goal, :body, presence: true
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  belongs_to(
    :goal,
    class_name: "Goal",
    foreign_key: :goal_id,
    primary_key: :id,
    inverse_of: :comments
  )
end
