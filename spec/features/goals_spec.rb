require 'rails_helper'

feature "goals" do
  
  feature "creating goals" do
    before(:each) do
      user = FactoryGirl.create(:user)
      sign_up(user)
      visit new_user_goal_url(user)
    end
    
    it "should have the title 'new goal'" do
      expect(page).to have_css 'h1', text: 'New Goal'
    end
    
    it "should have a form to add a goal" do
      expect(page).to have_content 'Goal'
      expect(page).to have_content 'Description'
      expect(page).to have_button 'Set Goal!'
    end
    
    it "should require the goal to have a title" do
      fill_in 'Description', with: 'A difficult goal'
      click_button 'Set Goal!'
      
      expect(page).to have_content "Title can't be blank"
    end
    
    it "requires the goal to have a description" do
      fill_in 'Goal', with: "Difficult Goal"
      click_button 'Set Goal!'
      
      expect(page).to have_content "Description can't be blank"
    end
    
    it "redirects to the goal page when correctly filled out" do
      fill_in 'Goal', with: "Difficult Goal"
      fill_in 'Description', with: 'A difficult goal'
      click_button 'Set Goal!'
      
      expect(page).to have_css 'h1', text: 'Difficult Goal'
    end
  end
  
end