require 'spec_helper'

feature 'Sessions' do
  context "on home page" do
    it "can click a register link" do
      visit root_url
      expect(page).to have_content "D'well"
      click_link "Register"
    end
  end

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
