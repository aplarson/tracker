require 'rails_helper'

feature "the signup process" do 
  before(:each) { visit '/users/new' }

  it "has a new user page" do
    expect(page).to have_content 'Sign Up'
  end
  
  it "has a form to sign up" do
    expect(page).to have_content 'Username'
    expect(page).to have_content 'Password'
  end

  feature "signing up a user" do
    before(:each) { visit '/users/new' }

    
    it "requires a username" do
      fill_in "Password", with: "password"
      click_button "Sign Up"
      
      expect(page).to have_content "Username can't be blank"
    end
    
    it "requires a 6 character password" do
      fill_in "Username", with: "user"
      click_button "Sign Up"
      
      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end

    it "shows username on the homepage after signup" do
      sign_up_new_guy
      
      expect(page).to have_content "new_guy"
    end

  end

end

feature "logging in" do 
  before(:each) { visit '/session/new' }
  
  it "has a log in form" do 
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Username'
    expect(page).to have_content 'Password'
  end
  
  it "logs in a user with correct information and not with wrong information" do
    sign_up_new_guy
    sign_in_new_guy
    
    expect(page).to have_content 'new_guy'
  end


  it "shows username on the homepage after login" do
    sign_up_new_guy
    sign_in_new_guy
    
    expect(page).to have_content 'new_guy'
  end

end

feature "logging out" do 

  it "begins with logged out state" do
    visit 'session/new'
    
    expect(page).not_to have_button 'Sign Out'
  end

  it "doesn't show username on the homepage after logout" do
    sign_up_new_guy
    click_button "Sign Out"
    expect(page).not_to have_content 'new_guy'
  end

end