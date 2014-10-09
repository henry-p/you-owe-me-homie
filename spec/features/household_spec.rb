require 'spec_helper'

feature "Household" do
  before(:each) do
    visit root_url
    User.create!(first_name: "Sam", last_name: "Spade", email: "sam@test.com", password: "pow", password_confirmation: "pow")
    fill_in 'user_email', with: "sam@test.com"
    fill_in 'user_password', with: "pow"
    first('input[type="submit"]').click
  end

  context "user is logged in" do
    it "should be able to create a new household" do
      expect {
        click_link "Create dwelling"
        fill_in 'name', with: "da hacker house"
        fill_in 'address', with: "555 Kinzie"
        first('input[value="Create Dwelling"]').click
      }.to change(Household, :count).by(1)
    end

    it "should not create a new household if no address or name" do
      expect {
        click_link "Create dwelling"
        fill_in 'name', with: "da hacker house"
        fill_in 'address', with: ""
        first('input[value="Create Dwelling"]').click
      }.to change(Household, :count).by(0)
      expect(page).to have_content("New Dwelling")
    end
  end


end
