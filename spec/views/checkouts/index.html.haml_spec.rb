require 'rails_helper'

RSpec.describe "checkouts/index", type: :view do
  before(:each) do
    assign(:checkouts, [
      Checkout.create!(
        :latitude => "9.99",
        :longitude => "9.99",
        :mentor => nil,
        :school => nil
      ),
      Checkout.create!(
        :latitude => "9.99",
        :longitude => "9.99",
        :mentor => nil,
        :school => nil
      )
    ])
  end

  it "renders a list of checkouts" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
