step "show me the page" do
  save_and_open_page
end

step "I click the link :link_text" do |link_text|
  page.click_link link_text
end

step "I click the button :button_text" do |button_text|
  page.click_button button_text
end

step "I fill out the form with :model :field_name :field_value" do |model, field_name, field_value|
  page.fill_in "#{model}_#{field_name}", :with => field_value
end
