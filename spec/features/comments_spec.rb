require 'rails_helper'

feature "comments" do
  feature "on goals" do
    given!(:goal) { FactoryGirl.create(:goal) }
    given!(:motivation) { Faker::Hacker.say_something_smart }
    before(:each) do
      sign_in_new_guy
      visit goal_url(goal)
    end
    
    it "should have a comment form on a goal" do
      expect(page).to have_button "Add Comment"
    end
    
    it "should allow users to make comments on goals" do
      fill_in "Comment", with: motivation
      click_button "Add Comment"
      
      expect(page).to have_content motivation
    end
    
    it "should allow users to remove comments from goals" do
      fill_in "Comment", with: motivation
      click_button "Add Comment"
      click_button "Remove Comment"
      
      expect(page).not_to have_content motivation
    end
    
    it "should display previous comments" do
      fill_in "Comment", with: motivation
      click_button "Add Comment"
      fill_in "Comment", with: Faker::Hacker.say_something_smart
      click_button "Add Comment"
      
      expect(page).to have_content motivation
    end
  end
  
  feature "on users" do
    given!(:goal) { FactoryGirl.create(:goal) }
    given!(:motivation) { Faker::Hacker.say_something_smart }
    before(:each) do
      sign_in_new_guy
      visit user_url(1)
    end
    
    it "should allow users to make comments on users" do
      fill_in "Comment", with: motivation
      click_button "Add Comment"
      
      expect(page).to have_content motivation
    end
    
    it "should allow users to remove comments from users" do
      fill_in "Comment", with: motivation
      click_button "Add Comment"
      click_button "Remove Comment"
      
      expect(page).not_to have_content motivation
    end
    
    it "should display previous comments" do
      fill_in "Comment", with: motivation
      click_button "Add Comment"
      fill_in "Comment", with: Faker::Hacker.say_something_smart
      click_button "Add Comment"
      
      expect(page).to have_content motivation
    end
  end
end