require 'spec_helper'

describe "New User Registrations" do

  it 'should have a link to sign up on the homepage' do
    visit root_path
    page.should have_link 'Sign up'
    click_link 'Sign up'
    current_path.should == new_user_registration_path
  end

  context 'registration page' do
    before do
      visit new_user_registration_path
    end
    it 'should have the additional user fields on the registration page' do
      page.should have_field 'user_first_name'
      page.should have_field 'user_last_name'
      page.should have_field 'user_email'
      page.should have_field 'user_password'
      page.should have_field 'user_password_confirmation'
      page.should have_button 'Sign up'
    end

    context 'required non-devise fields' do
      before do
        fill_in 'user_email', :with => 'FF@example.com'
        fill_in 'user_password', :with => 'password'
        fill_in 'user_password_confirmation', :with => 'password'
      end

      it 'should require first name' do
        fill_in 'user_last_name', :with => 'Footer'
        click_button 'Sign up'
        page.should have_content "First name can't be blank"
      end

      it 'should require last name' do
        fill_in 'user_first_name', :with => 'Frank'
        click_button 'Sign up'
        page.should have_content "Last name can't be blank"
      end
    end
  end
end
