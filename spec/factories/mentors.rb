FactoryGirl.define do
  factory :mentor do
    name 'mentor rspec'
    email 'mentorspec@superspec.berkeley.edu'
    school School.find_by(name: 'Berkeley Arts Magnet School')
  end
end
