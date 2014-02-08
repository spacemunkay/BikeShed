require 'spec_helper'

describe "New User Registrations" do
  it 'should have a link to sign up on the homepage' do
    visit root_path
    page.should have_link 'Register'
    click_link 'Register'
    current_path.should == new_user_registration_path
  end

  context 'registration page' do
    before do
      visit new_user_registration_path
    end
    it 'should have the additional user fields on the registration page' do
      page.should have_field 'First name'
      page.should have_field 'Last name'
      page.should have_field 'Nickname'
      page.should have_field 'Email'
      page.should have_field 'Password'
      page.should have_field 'Password confirmation'
      page.should have_button 'Sign up'
    end

    context 'required non-devise fields' do
      before do
        fill_in 'Email', :with => 'FF@example.com'
        fill_in 'Password', :with => 'password'
        fill_in 'Password confirmation', :with => 'password'
      end

      it 'should require first name' do
        fill_in 'Last name', :with => 'Footer'
        click_button 'Sign up'
        page.should have_content "First name can't be blank"
      end

      it 'should require last name' do
        fill_in 'First name', :with => 'Frank'
        click_button 'Sign up'
        page.should have_content "Last name can't be blank"
      end
    end
  end
end
