require "spec_helper"

feature "Bikes" do
  before(:each) do
    # create brand and wheel size
    @bike_brand = BikeBrand.create( brand: "Huffy")
    @bike_wheel_size = BikeWheelSize.create( description: "MyWheelSize")

    @user = FactoryGirl.create(:bike_admin)
    visit new_user_session_path
    fill_in "user_username", with: @user.username
    fill_in "user_password", with: @user.password
    click_button "Sign in"
  end

  scenario "User creates a new bike", js: true do
    visit new_bike_path
    fill_in "shop_id", with: 1
    fill_in "model", with: "Huffle Puffle"
    fill_in "serial_number", with: "XKCD"
    find('label.btn.btn-default', text: 'RD').click
    find('label.btn.btn-default', text: 'Poor').click
    fill_in "seat_tube_height", with: 52
    select @bike_brand.brand, from: "bike_brand_id"
    select @bike_wheel_size.description, from: "bike_wheel_size_id"
    click_button "Add Bike"
    expect(page).to have_text(@bike_brand.brand)
  end

  scenario "User submits a bike with errors", js: true do
    visit new_bike_path
    click_button "Add Bike"
    expect(page).to have_text(:all, "is not a number")
    expect(page).to have_text(:all, "is not a valid brand")
    expect(page).to have_text(:all, "is too short")
    expect(page).to have_text(:all, "is not a valid style")
    expect(page).to have_text(:all, "is not a valid wheel size")
    expect(page).to have_text(:all, "is not a valid condition")
  end
end
