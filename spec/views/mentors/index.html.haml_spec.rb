require 'rails_helper'

RSpec.describe "mentors/index", type: :view do
  before(:each) do
    assign(:mentors, [
      Mentor.create!(
        :name => "Name",
        :email => "Email",
        :school => nil
      ),
      Mentor.create!(
        :name => "Name",
        :email => "Email",
        :school => nil
      )
    ])
  end

  it "renders a list of mentors" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
