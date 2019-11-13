require 'rails_helper'

RSpec.describe "schools/new", type: :view do
  before(:each) do
    assign(:school, School.new(
      :name => "MyString",
      :address => "MyString",
      :latitude => "9.99",
      :longitude => "9.99",
      :admin => nil
    ))
  end

  it "renders new school form" do
    render

    assert_select "form[action=?][method=?]", schools_path, "post" do

      assert_select "input[name=?]", "school[name]"

      assert_select "input[name=?]", "school[address]"

      assert_select "input[name=?]", "school[latitude]"

      assert_select "input[name=?]", "school[longitude]"

      assert_select "input[name=?]", "school[admin_id]"
    end
  end
end
