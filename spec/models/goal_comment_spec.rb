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

require 'rails_helper'

RSpec.describe GoalComment, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end