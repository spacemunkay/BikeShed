step "I login with email :email and password :password" do |email, password|
  visit new_user_session_path
  fill_in 'Email', :with => email
  fill_in 'Password', :with => password
  click_button 'Sign in'
  page.should have_content("Signed in successfully.")
end
