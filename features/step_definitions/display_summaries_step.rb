Given("the following schools exist:") do |table|
  table.hashes.each do |school|
    School.create school
  end
end

Given("the following admins exist:") do |table|
  table.hashes.each do |admin|
    Admin.create admin
  end
end

Given("the following mentors exist:") do |table|
  table.hashes.each do |mentor|
    Mentor.create mentor
  end
end

Given("the following checkins exist:") do |table|
  table.hashes.each do |checkin|
    Checkin.create checkin
  end
end

Given("the following checkouts exist:") do |table|
  table.hashes.each do |checkout|
    Checkout.create checkout
  end
end

Given("I am signed in as an admin {string}") do |string|
  user  =  Admin.where(name: string)
  email = Admin.where(name: string).email
  headers = {}
  Rack::Utils.set_cookie_header!(headers, "email_address", @user.email)
  cookie_string = headers['Set-Cookie']
  Capybara.current_session.driver.browser.set_cookie(cookie_string)
end

Given("I am on the {string} page") do |string|
  visit path_to(string)
end

Then("I should see the the following table row :") do |table|
  if page.respond_to? :should
    page.should have_content(table)
  else
      assert page.has_content(table)
  end
end