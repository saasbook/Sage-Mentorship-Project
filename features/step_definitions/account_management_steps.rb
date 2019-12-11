When(/^I press the "(.*)" link$/) do |link_name|
  click_link(link_name)
end

When(/^I press the "(.*)" button$/) do |button_label|
  click_button(button_label)
end

When(/^I type in "(.*)" in the input box labeled "(.*)"$/) do |input_value, input_label|
  fill_in(input_label, :with => input_value)
end

When(/^I choose "(.*)" in the select box labeled "(.*)"$/) do |select_value, select_label|
  select(select_value, :from => select_label)
end

Then(/^I should be redirected to the "(.*)" page$/) do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path_to(page_name))
end

Given(/^I delete this "(.*)" record:$/) do |table_name, table|
    table.hashes.each do |row|
        row["school_id"] = School.find_by_name(row["school_id"]).id if !row["school_id"].nil?
        row["mentor_id"] = Mentor.find_by_name(row["mentor_id"]).id if !row["mentor_id"].nil?
        record = School.where(row).first if table_name == "school"
        record = Super.where(row).first if table_name == "super"
        record = Admin.where(row).first if table_name == "admin"
        record = Mentor.where(row).first if table_name == "mentor"
        record = Checkin.where(row).first if table_name == "checkin"
        record = Checkout.where(row).first if table_name == "checkout"
        record.destroy
    end
end

Then(/^I should have this "(.*)" record:$/) do |table_name, table|
    table.hashes.each do |row|
        row["school_id"] = School.find_by_name(row["school_id"]).id if !row["school_id"].nil?
        row["mentor_id"] = Mentor.find_by_name(row["mentor_id"]).id if !row["mentor_id"].nil?
        row["checkin_time"] = Time.parse(row["checkin_time"]) if !row["checkin_time"].nil?
        row["checkout_time"] = Time.parse(row["checkout_time"]) if !row["checkout_time"].nil?
        record = School.where(row).first if table_name == "school"
        record = Super.where(row).first if table_name == "super"
        record = Admin.where(row).first if table_name == "admin"
        record = Mentor.where(row).first if table_name == "mentor"
        record = Checkin.where(row).first if table_name == "checkin"
        record = Checkout.where(row).first if table_name == "checkout"
        expect(record).not_to be_nil
    end
end

Then(/^I should no longer have this "(.*)" record:$/) do |table_name, table|
    table.hashes.each do |row|
        school_name = row["school_id"]
        mentor_name = row["mentor_id"]
        row.delete("school_id")
        row.delete("mentor_id")
        row["checkin_time"] = Time.parse(row["checkin_time"]) if !row["checkin_time"].nil?
        row["checkout_time"] = Time.parse(row["checkout_time"]) if !row["checkout_time"].nil?

        record = School.where(row).first if table_name == "school"
        record = Super.where(row).first if table_name == "super"
        if table_name == "admin"
            record = Admin.where(row).joins(:school)
            record = record.where(schools: {name: school_name}).first
        end
        if table_name == "mentor"
            record = Mentor.where(row).joins(:school)
            record = record.where(schools: {name: school_name}).first
        end
        if table_name == "checkin"
            record = Checkin.where(row).joins(:school, :mentor)
            record = record.where(mentors: {name: mentor_name}, schools: {name: school_name}).first
        end
        if table_name == "checkout"
            record = Checkout.where(row).joins(:school, :mentor)
            record = record.where(mentors: {name: mentor_name}, schools: {name: school_name}).first
        end

        expect(record).to be_nil
    end
end

