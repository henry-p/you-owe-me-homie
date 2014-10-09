require 'spec_helper'

feature "Group" do
  before(:each) do
    visit root_url
    User.create!(first_name: "Sam", last_name: "Spade", email: "sam@test.com", password: "pow", password_confirmation: "pow")
    fill_in 'user_email', with: "sam@test.com"
    fill_in 'user_password', with: "pow"
    first('input[type="submit"]').click
  end

  context "user is logged in" do
    it "should be able to create a new group" do
      expect {
        click_link "Create group"
        fill_in 'name', with: "da hacker house"
        fill_in 'blurb', with: "555 Kinzie"
        first('input[value="Create Group"]').click
      }.to change(Group, :count).by(1)
    end

    it "should not create a new group if no blurb or name" do
      expect {
        click_link "Create group"
        fill_in 'name', with: ""
        fill_in 'blurb', with: "blurbby"
        first('input[value="Create Group"]').click
      }.to change(Group, :count).by(0)
      expect(page).to have_content("Name can't be blank")
    end

    it 'should assign current user to new group' do
      @user = User.find_by(email: "sam@test.com")
      expect {
        click_link "Create group"
        fill_in 'name', with: "da hacker house"
        fill_in 'blurb', with: "555 kinzie"
        first('input[value="Create Group"]').click
      }.to change(@user.groups, :count).by(1)
    end
  end

  it 'should allow users to edit a group' do
    click_link "Create group"
    fill_in 'name', with: "da hacker house"
    fill_in 'blurb', with: "blurbby"
    first('input[value="Create Group"]').click
    @user = User.find_by(email: "sam@test.com")
    @group = @user.groups.first
    visit group_path(@group)
    click_link 'Edit Group'
    expect(page).to have_content("Add member")
    click_button("Add member")
    # save_and_open_page
    # expect(page).to have_css("input[name='users[0]']")
  end

end
