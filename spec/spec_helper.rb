ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end


  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end


end


def sign_up(username)
  visit '/users/new'
  fill_in "Username", with: username
  fill_in "Password", with: "password"
  click_button "Sign Up"
end

def sign_up_new_guy
  sign_up('new_guy')
end

def sign_in(username)
  visit '/session/new'
  fill_in "Username", with: username
  fill_in "Password", with: 'password'
  click_button "Sign In"
end

def sign_in_new_guy
  sign_in('new_guy')
end

def set_goal(user)
  visit new_user_goal_url(user)
  fill_in 'Goal', with: "Difficult Goal"
  fill_in 'Description', with: 'A difficult goal'
  click_button 'Set Goal!'
end