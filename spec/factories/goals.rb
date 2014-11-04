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

FactoryGirl.define do
  factory :goal do
    title 'Difficult Goal'
    description 'A difficult goal'
    user
  end
  
  factory :private_goal do
    title 'Difficult Goal'
    description 'A difficult goal'
    user
    privacy true
  end
  

end
