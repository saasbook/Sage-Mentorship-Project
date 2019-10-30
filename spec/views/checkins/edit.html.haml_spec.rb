require 'rails_helper'

RSpec.describe "checkins/edit", type: :view do
  before(:each) do
    @checkin = assign(:checkin, Checkin.create!(
      :latitude => "9.99",
      :longitude => "9.99",
      :mentor => nil,
      :school => nil
    ))
  end

  it "renders the edit checkin form" do
    render

    assert_select "form[action=?][method=?]", checkin_path(@checkin), "post" do

      assert_select "input[name=?]", "checkin[latitude]"

      assert_select "input[name=?]", "checkin[longitude]"

      assert_select "input[name=?]", "checkin[mentor_id]"

      assert_select "input[name=?]", "checkin[school_id]"
    end
  end
end
