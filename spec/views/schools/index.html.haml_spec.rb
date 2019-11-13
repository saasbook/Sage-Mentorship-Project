require 'rails_helper'

RSpec.describe "schools/index", type: :view do
  before(:each) do
    assign(:schools, [
      School.create!(
        :name => "Name",
        :address => "Address",
        :latitude => "9.99",
        :longitude => "9.99",
        :admin => nil
      ),
      School.create!(
        :name => "Name",
        :address => "Address",
        :latitude => "9.99",
        :longitude => "9.99",
        :admin => nil
      )
    ])
  end

  it "renders a list of schools" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
