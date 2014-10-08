require 'spec_helper'

feature 'Login' do
  context "on home page" do
    it "can click a register link" do
      visit root_url
      click_link "Register"
    end

    it "can login" do
      visit root_url
      user = User.create!(first_name: "Sam", last_name: "Spade", email: "sam@test.com", password: "pow", password_confirmation: "pow")
      fill_in 'user_email', with: "sam@test.com"
      fill_in 'user_password', with: "pow"
      expect(page).to_not have_content("samt@test.com")
      first('input[type="submit"]').click
      expect(page).to have_content("Sam")
    end

    it "can display invalid login messages" do
      visit root_url
      user = User.create!(first_name: "Sam", last_name: "Spade", email: "sam@test.com", password: "pow", password_confirmation: "pow")
      fill_in 'user_email', with: "sam@test.com"
      fill_in 'user_password', with: "pop"
      expect(page).to_not have_content("samt@test.com")
      first('input[type="submit"]').click
      expect(page).to have_content("Invalid email or password")
    end
  end
end
