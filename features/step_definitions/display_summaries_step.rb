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

Given("I am signed in as admin {string}") do |admin_email|
  user = Admin.where(email: admin_email).first
  allow_any_instance_of(LoginsController).to receive(:authenticate_with_google).and_return(user)
  visit create_login_path
end

When /^(?:|I )am on the (.+)$/ do |page_name|
  visit path_to(page_name)
end

When("I enter {string} as date and I press {string}") do |date, select|
  fill_in 'week_date', :with => date
  click_button(select)
end

Then("I should see the the following table row :") do |table|
  table.hashes.each do |row|
    find(:table_row, row)
  end
end

Given("I am on the {string} page and pass {string} as mentor") do |string, string2|
  mentor = Mentor.where(name: string2).first
  visit mentor_details_path(mentor)
  
end

Given("I am on the {string} page and pass {string} as mentor and {string} as date") do |string, string2, string3|
  mentor = Mentor.where(name: string2).first
  visit mentor_attendacnes_path(mentor, :name => string2, :week_date => string3)
end

