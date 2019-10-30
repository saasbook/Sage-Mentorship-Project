require 'rails_helper'

RSpec.describe "checkouts/show", type: :view do
  before(:each) do
    @checkout = assign(:checkout, Checkout.create!(
      :latitude => "9.99",
      :longitude => "9.99",
      :mentor => nil,
      :school => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
