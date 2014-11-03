require 'rails_helper'

feature "goals" do
  
  feature "creating goals" do
    given!(:user) { FactoryGirl.create(:user) }
    before(:each) do
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
      set_goal(user)
      
      expect(page).to have_css 'h1', text: 'Difficult Goal'
    end
  end
  
  feature "displaying goals" do
    
    given!(:goal) { FactoryGirl.create(:goal) }
    
    
    it "displays title" do
      sign_in_new_guy
      visit goal_url(goal)
      expect(page).to have_css "h1", text: 'Difficult Goal'
    end
    
    it "displays description" do
      sign_in_new_guy
      visit goal_url(goal)
      expect(page).to have_content 'A difficult goal'
    end
    
    feature "displaying private goals" do
      given!(:private_goal) do
        Goal.create(
          title: 'Private Goal',
          description: 'A very private goal',
          user: FactoryGirl.create(:secretive_user),
          privacy: true
        )
      end
      given!(:another_user) { FactoryGirl.create(:another_user) }
      
      it "shows private goals to the user" do
        sign_in('secret_girl')
        visit goal_url(private_goal)
      
        expect(page).to have_content 'Private Goal'
      end
    
      it "does not show private goals to other users" do
        sign_in_new_guy
        visit goal_url(private_goal)
      
        expect(page).to have_content 'This goal is private'
      end
    end
    
    
  end
  
end