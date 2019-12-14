FactoryGirl.define do
  factory :admin do
    name 'admin rspec'
    email 'adminrspec@superspec.berkeley.edu'
    school School.find_by(name: 'Berkeley Arts Magnet School')
  end
end