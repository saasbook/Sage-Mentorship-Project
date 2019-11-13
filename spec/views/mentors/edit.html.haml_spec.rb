require 'rails_helper'

RSpec.describe "mentors/edit", type: :view do
  before(:each) do
    @mentor = assign(:mentor, Mentor.create!(
      :name => "MyString",
      :email => "MyString",
      :school => nil
    ))
  end

  it "renders the edit mentor form" do
    render

    assert_select "form[action=?][method=?]", mentor_path(@mentor), "post" do

      assert_select "input[name=?]", "mentor[name]"

      assert_select "input[name=?]", "mentor[email]"

      assert_select "input[name=?]", "mentor[school_id]"
    end
  end
end
