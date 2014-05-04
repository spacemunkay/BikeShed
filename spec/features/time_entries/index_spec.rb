require "spec_helper"

feature "TimeEntries" do
  let!(:user){ FactoryGirl.create(:user) }
  let!(:entry){ FactoryGirl.create(:time_entry, loggable_id: user.id) }

  before(:each) do
    visit new_user_session_path
    fill_in "user_username", with: user.username
    fill_in "user_password", with: user.password
    click_button "Sign in"
  end

  scenario "User deletes a time entry", js: true do
    visit time_entries_path
    puts TimeEntry.where(loggable_id: user.id).inspect
    save_screenshot("/tmp/testingpoop.png")
    find('button.work_entry-delete-btn').trigger('click')
    click_button "Delete"
    expect(page).to have_text("Your Timesheet")
    expect(TimeEntry.count).to eql 0
  end
end
