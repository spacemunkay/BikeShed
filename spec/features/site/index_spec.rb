require 'spec_helper'

describe "Index Page" do

  before(:each) do
    @user = FactoryGirl.create(:bike_admin)
    visit root_path
    fill_in "user_username", with: @user.username
    fill_in "user_password", with: @user.password
  end

  it 'should have a link to check in' do
    page.should have_button 'CHECK IN'
  end

  it 'should have a link to check out' do
    page.should have_button 'CHECK OUT'
  end

  it 'clicking check in should check in a user', js: true do
    pending
    expect{click_button 'CHECK IN'}.
      to change{@user.checked_in?}.
      from(false).to(true)
  end

  it 'clicking check out should check out a user', js: true do
    pending
    @user.checkin
    expect{click_button 'CHECK OUT'}.
      to change{@user.checked_in?}.
      from(true).to(false)
  end
end
