# == Schema Information
#
# Table name: user_comments
#
#  id         :integer          not null, primary key
#  subject_id :integer          not null
#  author_id  :integer          not null
#  body       :text             not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :user_comment do
    
  end

end
