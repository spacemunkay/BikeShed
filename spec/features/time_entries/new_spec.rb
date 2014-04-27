require "spec_helper"

feature "TimeEntries" do
  let!(:user){ FactoryGirl.create(:user) }

  before(:each) do
    visit new_user_session_path
    fill_in "user_username", with: user.username
    fill_in "user_password", with: user.password
    click_button "Sign in"
  end

  scenario "User creates a new time entry", js: true do
    visit new_time_entry_path
    fill_in "date_id", with: "04/27/2014"
    fill_in "start_time_id", with: "3:00 PM"
    fill_in "end_time_id", with: "3:15 PM"
    find('label.btn.btn-default', text: 'Personal').trigger('click')
    fill_in "description_id", with: "My Description"
    click_button "Add Time Entry"
    expect(page).to have_text("My Description")
    expect(TimeEntry.count).to be > 0
  end

  scenario "User submits a time entry with errors", js: true do
    visit new_time_entry_path
    click_button "Add Time Entry"
    expect(page).to have_text(:all, "can't be blank")
  end

end
