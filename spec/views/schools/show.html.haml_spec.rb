require 'rails_helper'

RSpec.describe "schools/show", type: :view do
  before(:each) do
    @school = assign(:school, School.create!(
      :name => "Name",
      :address => "Address",
      :latitude => "9.99",
      :longitude => "9.99",
      :admin => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
  end
end
