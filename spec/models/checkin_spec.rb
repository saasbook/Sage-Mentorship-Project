require 'rails_helper'

RSpec.describe Checkin, type: :model do
  before(:all) do
    @school1 = School.find_by(name: 'Berkeley Arts Magnet School') || create(:school)
    @mentor1 =  Mentor.find_by(email: 'mentorspec1@superspec.berkeley.edu') || create(:mentor, :name => 'mentorspec1', :email => 'mentorspec1@superspec.berkeley.edu', :school => @school1)
  end
  after(:each) do
    Checkin.delete_all;Checkout.delete_all;Mentor.delete_all;Super.delete_all;Admin.delete_all;School.delete_all
  end
  let(:checkout1_attributes) {
    {checkout_time: Time.now+30.seconds, checkout_lat: 37.876869, checkout_lon: -122.270348, mentor_id: @mentor1.id, school_id: @mentor1.school_id}
  }
  let(:checkout2_attributes) {
    {checkout_time: Time.now+30.hours, checkout_lat: 37.876869, checkout_lon: -122.270348, mentor_id: @mentor1.id, school_id: @mentor1.school_id}
  }
  let(:checkin_attributes) {
    {checkin_time: Time.now, checkin_lat: 37.876869, checkin_lon: -122.270348, mentor_id: @mentor1.id, school_id: @mentor1.school_id}
  }

  describe "correspond_checkout" do
      it "returns the checkout that is on the same day as the checkin" do
        checkin = Checkin.create! checkin_attributes
        checkout1 = Checkout.create! checkout1_attributes
        checkout2 = Checkout.create! checkout2_attributes
        expect(checkin.correspond_checkout.id).to eq(checkout1.id)
      end
  end
end
