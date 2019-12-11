require 'cucumber/rspec/doubles'

Given(/^the following schools exist:$/) do |table|
  table.hashes.each do |school|
    School.create school
  end
end

Given(/^the following supers exist:$/) do |table|
  table.hashes.each do |super_user|
    Super.create super_user
  end
end

Given(/^the following admins exist:$/) do |table|
  table.hashes.each do |admin|
    admin["school_id"] = School.find_by_name(admin["school_id"]).id
    Admin.create admin
  end
end

Given(/^the following mentors exist:$/) do |table|
  table.hashes.each do |mentor|
    mentor["school_id"] = School.find_by_name(mentor["school_id"]).id
    Mentor.create mentor
  end
end

Given(/^the following checkins exist:$/) do |table|
  table.hashes.each do |checkin|
    checkin["mentor_id"] = Mentor.find_by_name(checkin["mentor_id"]).id
    checkin["school_id"] = School.find_by_name(checkin["school_id"]).id
    Checkin.create checkin
  end
end

Given(/^the following checkouts exist:$/) do |table|
  table.hashes.each do |checkout|
    checkout["mentor_id"] = Mentor.find_by_name(checkout["mentor_id"]).id
    checkout["school_id"] = School.find_by_name(checkout["school_id"]).id
    Checkout.create checkout
  end
end

Given(/^I am signed in as an "(.*)", "(.*)"$/) do |user_type, user_name|
  user = Super.find_by_name(user_name) if user_type == "super"
  user = Admin.find_by_name(user_name) if user_type == "admin"
  user = Mentor.find_by_name(user_name) if user_type == "mentor"
  allow_any_instance_of(ApplicationController).to receive(:find_user_by_email).and_return(user)
end

Given(/^I am on the "(.*)" page$/) do |page_name|
    visit path_to(page_name)
end

Then(/^I should see the the following table row :$/) do |table|
  table.hashes.each do |row|
    find(:table_row, row)
  end
end

