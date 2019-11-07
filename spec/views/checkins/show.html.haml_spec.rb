require 'rails_helper'

RSpec.describe "checkins/show", type: :view do
  before(:each) do
    @checkin = assign(:checkin, Checkin.create!(
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
