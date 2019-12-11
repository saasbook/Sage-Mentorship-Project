When(/^I try to access the "(.*)" page$/) do |page_name|
  puts(path_to(page_name))
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should be on the "(.*)" page$/) do |page_name|
  puts(path_to(page_name))
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should be redirected to the "(.*)" page with a "(.*)" notice message$/) do |notice_message|
  puts(notice_message)
  pending # Write code here that turns the phrase above into concrete actions
end
