When(/^I press the "(.*)" link$/) do |link_name|
  puts(link_name)
#  click_link(link_name)
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I press the "(.*)" link on the record row of "(.*)"$/) do |link_label, row_of|
  puts(link_label)
  puts(row_of)
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I press the "(.*)" button$/) do |button_label|
  puts(button_label)
#  click_button(button_label)
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I press "(.*)" in pop up$/) do |popup_click|
  puts(popup_click)
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I type in "(.*)" in the input box labeled "(.*)"$/) do |input_value, input_label|
  puts(input_value)
  puts(input_label)
#  fill_in(input_label, :with => input_value)
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I choose "(.*)" in the select box labeled "(.*)"$/) do |select_value, select_label|
  puts(select_value)
  puts(select_label)
#  select(select_value, :from => select_label)
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should be redirected to the "(.*)" page$/) do |page_name|
  puts(path_to(page_name))
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^a "(.*)" confirmation message poped up$/) do |popup_message|
  puts(popup_message)
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should have this "(.*)" record:$/) do |table_name, table|
    puts(table_name)
    table.hashes.each do |row|
        row["school_id"] = School.find_by_name(row["school_id"]).id if !row["school_id"].nil?
        row["mentor_id"] = Mentor.find_by_name(row["mentor_id"]).id if !row["mentor_id"].nil?
        puts(row)
#        ... if table_name == "schools"
#        ... if table_name == "supers"
#        ... if table_name == "admins"
#        ... if table_name == "mentors"
#        ... if table_name == "checkins"
#        ... if table_name == "checkouts"
    end
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should no longer have this "(.*)" record:$/) do |table_name, table|
    puts(table_name)
    table.hashes.each do |row|
        row["school_id"] = School.find_by_name(row["school_id"]).id if !row["school_id"].nil?
        row["mentor_id"] = Mentor.find_by_name(row["mentor_id"]).id if !row["mentor_id"].nil?
        puts(row)
#        ... if table_name == "schools"
#        ... if table_name == "supers"
#        ... if table_name == "admins"
#        ... if table_name == "mentors"
#        ... if table_name == "checkins"
#        ... if table_name == "checkouts"
    end
  pending # Write code here that turns the phrase above into concrete actions
end

