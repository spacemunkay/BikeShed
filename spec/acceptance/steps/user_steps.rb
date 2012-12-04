step "a user :email with password :password" do |email, password|
  FactoryGirl.create(:user, :email => email, :password => password)
end
