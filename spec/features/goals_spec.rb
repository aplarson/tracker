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
    
    it "makes a goal public by default"
    
    it "makes a goal private if the option is checked"
    
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
  
  feature 'goals index' do
    given!(:user) { FactoryGirl.create(:user)}
    given!(:goal) do
        Goal.create(
          title: 'Public Goal',
          description: 'A goal',
          user: user,
          privacy: false
        )
    end
    given!(:private_goal) do
        Goal.create(
          title: 'Private Goal',
          description: 'A very private goal',
          user: user,
          privacy: true
        )
    end
    
    it "shows a user's public goals" do
      sign_in('new_guy')
      visit user_goals_url(user)

      expect(page).to have_content 'Public Goal'
    end

    it "shows the user their own private goals" do
      sign_in('new_guy')
      visit user_goals_url(user)

      expect(page).to have_content 'Private Goal'
    end
    
    it "does not show other users a user's private goals" do
      other_user = FactoryGirl.create(:another_user)
      sign_in('newer_guy')
      visit user_goals_url(user)

      expect(page).to have_content 'Public Goal'
      expect(page).not_to have_content 'Private Goal'
    end
  end
  
  feature 'removing goals' do
    given!(:user) { FactoryGirl.create(:user)}
    given!(:goal) do
        Goal.create(
          title: 'Public Goal',
          description: 'A goal',
          user: user,
          privacy: false
        )
    end
    
    it "allows a user to remove their goals" do
      sign_in('new_guy')
      visit goal_url(goal)
      click_button "Remove Goal"
      
      expect(page).not_to have_content 'Public Goal'
    end
    
    it "does not allow a user to remove other users' goals" do
      other_user = FactoryGirl.create(:another_user)
      sign_in('newer_guy')
      
      expect(page).not_to have_content "Remove Goal"
    end
  end
  
  feature "updating goals" do
    given!(:user) { FactoryGirl.create(:user)}
    given!(:goal) do
        Goal.create(
          title: 'Public Goal',
          description: 'A goal',
          user: user,
          privacy: false
        )
    end
    
    it "allows a user to update their goals" do
      sign_in('new_guy')
      visit goal_url(goal)
      click_link "Update Goal"
      
      expect(page).to have_content "Edit Goal"
    end
    
    it "does not allow another user to update the user's goals" do
      other_user = FactoryGirl.create(:another_user)
      sign_in('newer_guy')
      
      expect(page).not_to have_content "Update Goal"
    end
    
    it "updates the goal on clicking the link" do
      sign_in('new_guy')
      visit edit_goal_url(goal)
      
      fill_in "Goal", with: "Updated Title"
      fill_in "Description", with: "Updated description"
      click_button "Update Goal"
      
      expect(page).to have_content "Updated Title"
      expect(page).to have_content "Updated description"
    end
  end
  
  feature "completing goals" do
    given!(:user) { FactoryGirl.create(:user)}
    given!(:goal) do
        Goal.create(
          title: 'Public Goal',
          description: 'A goal',
          user: user,
          privacy: false
        )
    end
    
    it "shows goals as incomplete on creation" do
      sign_in('new_guy')
      visit goal_url(goal)
      
      expect(page).to have_content "Goal in Progress!"
    end
    
    it "allows a user to record the completion of their goal" do
      sign_in('new_guy')
      visit edit_goal_url(goal)
      choose "Goal Complete!"
      click_button "Update Goal"
      
      expect(page).to have_content "Goal Completed!"
    end
    
    it "does not allow another user to complete the user's goal" do
      other_user = FactoryGirl.create(:another_user)
      sign_in('newer_guy')
      visit edit_goal_url(goal)
      
      expect(page).not_to have_content "Edit Goal"
    end
  end
  
end