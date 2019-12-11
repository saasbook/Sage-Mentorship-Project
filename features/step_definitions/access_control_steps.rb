When(/^I try to access the "(.*)" page$/) do |page_name|
  visit path_to(page_name)
end

Then(/^I should be on the "(.*)" page$/) do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path_to(page_name))
end

Then /^I should see the message "(.*)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^I sign out$/ do
  page.driver.submit :delete, "/logout", {}
  allow_any_instance_of(ApplicationController).to receive(:find_user_by_email).and_call_original
end

