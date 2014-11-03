# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

FactoryGirl.define do
  factory :user, class: 'User' do
    username 'new_guy'
    password 'password'
  end
  
  factory :another_user, class: 'User' do
    username 'newer_guy'
    password 'password'
  end

  factory :secretive_user, class: 'User' do
    username 'secret_girl'
    password 'password'
  end
end
