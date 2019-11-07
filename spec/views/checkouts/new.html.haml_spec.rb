require 'rails_helper'

RSpec.describe "checkouts/new", type: :view do
  before(:each) do
    assign(:checkout, Checkout.new(
      :latitude => "9.99",
      :longitude => "9.99",
      :mentor => nil,
      :school => nil
    ))
  end

  it "renders new checkout form" do
    render

    assert_select "form[action=?][method=?]", checkouts_path, "post" do

      assert_select "input[name=?]", "checkout[latitude]"

      assert_select "input[name=?]", "checkout[longitude]"

      assert_select "input[name=?]", "checkout[mentor_id]"

      assert_select "input[name=?]", "checkout[school_id]"
    end
  end
end
