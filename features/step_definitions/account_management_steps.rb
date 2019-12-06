Given("I am signed in as a {string}") do |string|
  user  =  Admin.where(name: string)
  cookies.signed[:user_id] = user.id
  session[:email_address] = user.email
  session[:id] = user.id
end

Given("I am on the {string} page with the {string} tab active") do |string, string2|
  visit path(string)
end

When("I press the “New Mentor” link") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should be redirected to the {string} page") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I type in {string} in the input box labeled {string}") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I choose {string} in the select box labeled {string}") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I press the “Save” button") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should have this {string} record:") do |string, table|
  # table is a Cucumber::MultilineArgument::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

When("I press the “Edit” link on the record row of {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("I press the “Destroy” link on the record row of {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("a {string} confirmation message poped up") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("I press {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should no longer have this {string} record:") do |string, table|
  # table is a Cucumber::MultilineArgument::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end
