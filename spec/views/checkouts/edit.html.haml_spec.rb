require 'rails_helper'

RSpec.describe "checkouts/edit", type: :view do
  before(:each) do
    @checkout = assign(:checkout, Checkout.create!(
      :latitude => "9.99",
      :longitude => "9.99",
      :mentor => nil,
      :school => nil
    ))
  end

  it "renders the edit checkout form" do
    render

    assert_select "form[action=?][method=?]", checkout_path(@checkout), "post" do

      assert_select "input[name=?]", "checkout[latitude]"

      assert_select "input[name=?]", "checkout[longitude]"

      assert_select "input[name=?]", "checkout[mentor_id]"

      assert_select "input[name=?]", "checkout[school_id]"
    end
  end
end
