require 'spec_helper'
# require 'selenium/client'

feature "Group" do
  before(:each) do
    visit root_url
    colin = User.create!(email: "colin@mail.com", password: "colin", password_confirmation: "colin", first_name: "Colin", last_name: "Shevlin")
    henry = User.create!(email: "henry@mail.com", password: "henry", password_confirmation: "henry", first_name: "Henry", last_name: "P")
    andrea = User.create!(email: "andrea@mail.com", password: "andrea", password_confirmation: "andrea", first_name: "Andrea", last_name: "Simenstad")
    padd = Group.create!(name: "Padd", blurb: "123 North Sesame Street")
    padd.users << colin
    padd.users << henry
    padd.users << andrea
    txn1 = Bill.create!(from_user: henry, to_user: colin, group_id: padd.id, amount: "100", confirmed: true)
    txn1 = Bill.create!(from_user: henry, to_user: colin, group_id: padd.id, amount: "25", confirmed: false)
    txn2 = Payment.create!(from_user: henry, to_user: colin, group_id: padd.id, amount: "50", confirmed: false)
    txn3 = Bill.create!(from_user: andrea, to_user: colin, group_id: padd.id, amount: "200", confirmed: true)
    txn4 = Bill.create!(from_user: colin, to_user: henry, group_id: padd.id, amount: "200", confirmed: true)
    txn5 = Payment.create!(from_user: colin, to_user: henry, group_id: padd.id, amount: "200", confirmed: true)
    fill_in 'user_email', with: "colin@mail.com"
    fill_in 'user_password', with: "colin"
    first('input[type="submit"]').click
  end

  context "user is logged in" do
    it "should be able to create a new group" do
      expect {
        visit root_path
        click_link "Create group"
        fill_in 'group_name', with: "da hacker house"
        fill_in 'group_blurb', with: "555 Kinzie"
        first('input[value="Create Group"]').click
      }.to change(Group, :count).by(1)
    end

    it "should not create a new group if no blurb or name" do
      expect {
        visit root_url
        click_link "Create group"
        fill_in 'group_name', with: ""
        fill_in 'group_blurb', with: "blurbby"
        first('input[value="Create Group"]').click
      }.to change(Group, :count).by(0)
      expect(page).to have_content("Name can't be blank")
    end

    it 'should assign current user to new group' do
      @user = User.find_by(email: "colin@mail.com")
      # expect {
        click_link "Create group"
        fill_in 'group_name', with: "da hacker house"
        fill_in 'group_blurb', with: "555 kinzie"
        first('input[value="Create Group"]').click
      # }.to change(@user.groups, :count).eq
      expect(@user.groups.count).to eq(1)
    end
  end

  context 'on the group edit page' do
    it 'user can leave a group' do
      @user = User.find_by(email: "colin@mail.com")
      click_link 'Padd'
      click_link 'Edit Group'
      # click_link 'Leave Group'
      # page.driver.browser.switch_to.alert.dismiss

      # This test works, but only when there is no confirmation for leaving a group.
      # expect{click_link 'Leave Group'}.to change(@user.groups, :count).by(-1)

      # This test should work for confirmation messages, but it requires using selenium
      # expect(page.driver.browser.switch_to.alert.accept).to change(@user.groups, :count).by(1)
    end
  end

  # it 'should allow users to edit a group', :js => true do
  #   visit root_url
  #   click_link "Create group"
  #   fill_in 'name', with: "da hacker house"
  #   fill_in 'blurb', with: "blurbby"
  #   first('input[value="Create Group"]').click
  #   @user = User.find_by(email: "sam@test.com")
  #   @group = @user.groups.first
  #   visit group_path(@group)
  #   click_link 'Edit Group'
  #   # expect(page).to have_content("Add member")
  #   click_button("Add member")
  #   save_and_open_page
  #   # expect(page).to have_css("input[name='users[0]']")
  # end
  context "on the group show page" do
    it "shows group member names" do
      visit group_path(Group.first)
      expect(page).to have_content("Henry P")
      expect(page).to have_content("Andrea Simenstad")
    end

    it "shows unconfirmed transactions for user" do
      visit group_path(Group.first)
      expect(page).to have_content "Payment from Henry P"
      expect(page).to have_content "Bill from Henry P"
      expect(page).to have_content "Confirm Transaction"
      expect(page).to have_content "$50"
    end

    it "does not show confirmed transactions for user" do
      visit group_path(Group.first)
      expect(page).to_not have_content "Payment from Andrea"
    end

    it "can confirm a transaction" do
      visit group_path(Group.first)
      user = User.find_by_email("colin@mail.com")
      initial_unconfirmed_count = Transaction.where(to_user: user, confirmed: false).count
      first(:link, "Confirm Transaction").click
      unconfirmed_count = Transaction.where(to_user: user, confirmed: false).count
      expect(initial_unconfirmed_count - unconfirmed_count).to eq 1
      expect(page).to_not have_content("Payment from Henry P")
    end
  end

end
