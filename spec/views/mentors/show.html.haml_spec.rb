require 'rails_helper'

RSpec.describe "mentors/show", type: :view do
  before(:each) do
    @mentor = assign(:mentor, Mentor.create!(
      :name => "Name",
      :email => "Email",
      :school => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(//)
  end
end
