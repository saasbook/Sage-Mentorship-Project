require 'cucumber/rspec/doubles'

And(/^the following (.*) exist:$/) do |table_name, table|
    table.hashes.each do |row|
        row["school_id"] = School.find_by_name(row["school_id"]).id if !row["school_id"].nil?
        row["mentor_id"] = Mentor.find_by_name(row["mentor_id"]).id if !row["mentor_id"].nil?

        School.create row if table_name == "schools"
        puts "the new school #{School.find_by(name: row["name"])} " if table_name == "schools"
        Super.create row if table_name == "supers"
        puts "the new super #{Super.find_by(name: row["name"])} " if table_name == "supers"
        Admin.create row if table_name == "admins"
        puts "the new admin #{Admin.find_by(name: row["name"])} " if table_name == "admins"
        Mentor.create row if table_name == "mentors"
        puts "#{row}\nthe new mentor #{Mentor.find_by(name: row["name"])} " if table_name == "mentors"
        Checkin.create row if table_name == "checkins"
        puts "the new checkin #{Checkin.find_by(mentor_id: row["name"])} " if table_name == "checkins"
        Checkout.create row if table_name == "checkouts"
        puts "the new checkin #{Checkout.find_by(mentor_id: row["name"])} " if table_name == "checkouts"
    end
end

And(/^I am signed in as an "(.*)", "(.*)"$/) do |user_type, user_name|
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

