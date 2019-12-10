require 'cucumber/rspec/doubles'

Given("the following schools exist:") do |table|
  table.hashes.each do |school|
    School.create school
  end
end

Given("the following admins exist:") do |table|
  table.hashes.each do |admin|
    admin["school_id"] = School.where(name: admin["school_id"]).first.id
    Admin.create admin
  end
end


Given("the following mentors exist:") do |table|
  table.hashes.each do |mentor|
    mentor["school_id"] = School.where(name: mentor["school_id"]).first.id
    Mentor.create mentor
  end
end

Given("the following checkins exist:") do |table|
  table.hashes.each do |checkin|
    checkin["mentor_id"] = Mentor.where(name: checkin["mentor_id"]).first.id
    checkin["school_id"] = School.where(name: checkin["school_id"]).first.id
    Checkin.create checkin
  end
end

Given("the following checkouts exist:") do |table|
  table.hashes.each do |checkout|
    checkout["mentor_id"] = Mentor.where(name: checkout["mentor_id"]).first.id
    checkout["school_id"] = School.where(name: checkout["school_id"]).first.id
    Checkout.create checkout
  end
end

Given("I am signed in as an admin {string}") do |admin_name|
  user  =  Admin.where(name: admin_name).first
  allow_any_instance_of(ApplicationController).to receive(:find_user_by_email).and_return(user)
end

Given("I am on the {string} page and I pass {string} as school and {string} date") do |page_name, school_name, week_date|
  if page_name == "schools"
    school = School.where(name: school_name).first
    visit school_path(school, :week_date => week_date)
  end
end

Then("I should see the the following table row :") do |table|
  table.hashes.each do |row|
    find(:table_row, row)
  end
end

Given("I am on the {string} page and pass {string} as mentor") do |page_name, mentor_name|
  if page_name == "weeks_summary"
      mentor = Mentor.where(name: mentor_name).first
      visit mentor_details_path(mentor)
  end
end

Given("I am on the {string} page and pass {string} as mentor and {string} as date") do |page_name, mentor_name, week_date|
  if page_name == "attendances"
    mentor = Mentor.where(name: mentor_name).first
    visit mentor_attendances_path(mentor, :week_date => week_date)
  end
end

