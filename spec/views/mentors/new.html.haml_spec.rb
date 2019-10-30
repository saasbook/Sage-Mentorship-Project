require 'rails_helper'

RSpec.describe "mentors/new", type: :view do
  before(:each) do
    assign(:mentor, Mentor.new(
      :name => "MyString",
      :email => "MyString",
      :school => nil
    ))
  end

  it "renders new mentor form" do
    render

    assert_select "form[action=?][method=?]", mentors_path, "post" do

      assert_select "input[name=?]", "mentor[name]"

      assert_select "input[name=?]", "mentor[email]"

      assert_select "input[name=?]", "mentor[school_id]"
    end
  end
end
