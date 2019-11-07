require 'rails_helper'

RSpec.describe "checkins/new", type: :view do
  before(:each) do
    assign(:checkin, Checkin.new(
      :latitude => "9.99",
      :longitude => "9.99",
      :mentor => nil,
      :school => nil
    ))
  end

  it "renders new checkin form" do
    render

    assert_select "form[action=?][method=?]", checkins_path, "post" do

      assert_select "input[name=?]", "checkin[latitude]"

      assert_select "input[name=?]", "checkin[longitude]"

      assert_select "input[name=?]", "checkin[mentor_id]"

      assert_select "input[name=?]", "checkin[school_id]"
    end
  end
end
