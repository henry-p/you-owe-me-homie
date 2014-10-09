require 'spec_helper'

feature "Create Bill" do
  before(:each) do
    visit root_url
    colin = User.create!(email: "colin@mail.com", password: "colin", password_confirmation: "colin", first_name: "Colin", last_name: "Shevlin")
    henry = User.create!(email: "henry@mail.com", password: "henry", password_confirmation: "henry", first_name: "Henry", last_name: "P")
    andrea = User.create!(email: "andrea@mail.com", password: "andrea", password_confirmation: "andrea", first_name: "Andrea", last_name: "Simenstad")
    padd = Group.create!(name: "Padd", blurb: "123 North Sesame Street")
    padd.users << colin
    padd.users << henry
    padd.users << andrea
    fill_in 'user_email', with: "colin@mail.com"
    fill_in 'user_password', with: "colin"
    first('input[type="submit"]').click
  end

  context "on group show page" do
    it "can create a transaction" do
      visit group_path(Group.first)
      click_link "Create Bill"
      save_and_open_page
      fill_in 'transaction_amount', with: "8.99"
    end
  end
end
