require 'spec_helper'

feature 'Register' do
  context "on register page" do
    it "can fill out registration form and click register" do
      visit new_user_path
      expect(page).to have_content "Register"
      expect {
        fill_in 'user_email', with: "test@test.co"
        fill_in 'user_first_name', with: "Test"
        fill_in 'user_last_name', with: "Ing"
        fill_in 'user_password', with: "test@test.co"
        fill_in 'user_password_confirmation', with: "test@test.co"
        first('input[type="submit"]').click
      }.to change(User, :count).by(1)
    end

    it "will show errors for invalid email" do
      visit new_user_path
      fill_in 'user_email', with: "testtest.co"
      fill_in 'user_first_name', with: "Test"
      fill_in 'user_last_name', with: "Ing"
      fill_in 'user_password', with: "test@test.co"
      fill_in 'user_password_confirmation', with: "test@test.co"
      expect(page).to_not have_content("test@test.co")
      first('input[type="submit"]').click
      expect(page).to have_content "Email is invalid"
    end

    it "will show errors for non-matching password" do
      visit new_user_path
      fill_in 'user_email', with: "test@test.co"
      fill_in 'user_first_name', with: "Test"
      fill_in 'user_last_name', with: "Ing"
      fill_in 'user_password', with: "test@test"
      fill_in 'user_password_confirmation', with: "test@test.co"
      first('input[type="submit"]').click
      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end
end

feature 'User home' do
  context 'Welcome page for logged in user' do
    it 'redirects to login if not logged in' do
      user = User.create!(first_name: "Sam", last_name: "Spade", email: "sam@test.com", password: "pow", password_confirmation: "pow")
      visit user_path(user)
      expect(page).to have_content("Register")
    end

    it 'redirects to show page from register/welcome page if logged in' do
      visit root_url
      user = User.create!(first_name: "Sam", last_name: "Spade", email: "sam@test.com", password: "pow", password_confirmation: "pow")
      fill_in 'user_email', with: "sam@test.com"
      fill_in 'user_password', with: "pow"
      first('input[type="submit"]').click
      visit root_url
      expect(page).to_not have_content("Register")
      visit new_user_url
      expect(page).to_not have_content("Register")
    end

    it 'displays the households of the user upon login' do
      visit root_url
      household = Household.create(name: "DBC", address: "W Hubbard")
      user = User.create!(first_name: "Sam", last_name: "Spade", email: "sam@test.com", password: "pow", password_confirmation: "pow")
      user.households << household
      fill_in 'user_email', with: "sam@test.com"
      fill_in 'user_password', with: "pow"
      expect(page).to_not have_content("samt@test.com")
      first('input[type="submit"]').click
      expect(page).to have_content("DBC")
    end
  end

  context "dwelling has been created" do
    before(:each) do
      visit root_url
      sam = User.create!(first_name: "Sam", last_name: "Spade", email: "sam@test.com", password: "pow", password_confirmation: "pow")
      household1 = Household.create!(name: "trap house", address: "54123 Kinzie")
      household2 = Household.create!(name: "hacker house", address: "123 Sesame street")
      household1.users << sam
      household2.users << sam
      fill_in 'user_email', with: "sam@test.com"
      fill_in 'user_password', with: "pow"
      first('input[type="submit"]').click
    end

    it "shows a link to the dwelling on the user's show page" do
      expect(page).to have_content('a', "trap house")
      expect(page).to have_content('a', "hacker house")
    end
  end
end

feature "Nav bar" do
  context "layout global everywhere" do
    it 'includes a logout button if user logged in' do
      visit root_url
      user = User.create!(first_name: "Sam", last_name: "Spade", email: "sam@test.com", password: "pow", password_confirmation: "pow")
      fill_in 'user_email', with: "sam@test.com"
      fill_in 'user_password', with: "pow"
      expect(page).to_not have_content 'Logout'
      first('input[type="submit"]').click
      expect(page).to have_content 'Logout'
      click_link 'Logout'
      expect(page).to have_content "Register"
    end
  end
end

