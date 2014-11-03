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
#

require 'rails_helper'

RSpec.describe Goal, :type => :model do
  it "has a title, description, and user" do
    expect(FactoryGirl.create(:goal)).to be_valid
  end
end
