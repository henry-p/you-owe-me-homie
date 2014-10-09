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
      expect {
        find('input[value="henry@mail.com"]').set(true)
        find('input[value="andrea@mail.com"]').set(true)
        fill_in 'transaction_amount', with: "8.99"
        first('input[type="submit"]').click
      }.to change(Transaction, :count).by(2)
    end

    it "cannot create a transaction with no members selected" do
      visit group_path(Group.first)
      click_link "Create Bill"
      expect {
        fill_in 'transaction_amount', with: "8.99"
        first('input[type="submit"]').click
      }.to change(Transaction, :count).by(0)
    end

    it "cannot create a transaction with invalid amount format" do
      visit group_path(Group.first)
      click_link "Create Bill"
      expect {
        find('input[value="andrea@mail.com"]').set(true)
        fill_in 'transaction_amount', with: "00"
        first('input[type="submit"]').click
        expect(page).to have_content("There was an issue creating the bill")
      }.to change(Transaction, :count).by(0)

      visit group_path(Group.first)
      click_link "Create Bill"
      expect {
        find('input[value="andrea@mail.com"]').set(true)
        fill_in 'transaction_amount', with: "asd"
        first('input[type="submit"]').click
      }.to change(Transaction, :count).by(0)

      visit group_path(Group.first)
      click_link "Create Bill"
      expect {
        find('input[value="andrea@mail.com"]').set(true)
        fill_in 'transaction_amount', with: "1.123"
        first('input[type="submit"]').click
      }.to change(Transaction, :count).by(0)
    end
  end
end







