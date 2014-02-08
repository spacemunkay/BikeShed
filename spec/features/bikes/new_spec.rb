require "spec_helper"

feature "Bikes" do
  before(:each) do
    @user = FactoryGirl.create(:bike_admin)
    visit new_user_session_path
    fill_in "user_username", with: @user.username
    fill_in "user_password", with: @user.password
    click_button "Sign in"
  end

  scenario "User creates a new bike" do
    visit new_bike_path
    fill_in "shop_id", with: 1
    fill_in "model", with: "Huffy"
    fill_in "serial_number", with: "XKCD"
    fill_in "seat_tube_height", with: 52
    click_button "Add Bike"
    expect(page).to have_text("Huffy")
  end

  scenario "User submits a bike with errors", js: true do
    visit new_bike_path
    click_button "Add Bike"
    expect(page).to have_text(:all, "is not a number")
    expect(page).to have_text(:all, "is too short")
  end
end
