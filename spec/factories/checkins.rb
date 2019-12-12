FactoryGirl.define do
  factory :checkin do
    checkin_time Time.now
    checkin_lat 37.876869
    checkin_lon -122.270348
    mentor_id 1
    school_id 1
  end
end