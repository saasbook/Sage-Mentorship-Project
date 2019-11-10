# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admins = [
{name:'Darain Noveir', email:'bam@sagementorship.org', school: 'Berkeley Arts Magnet School'},
{name:'Sweta Parija', email:'emerson@sagementorship.org', school: 'Emerson Elementary School'},
{name:'Megan Bendicto', email:'jefferson@sagementorship.org', school: 'Jefferson Elementary School'},
{name:'Nick Test Admin', email:'nwruhman@gmail.com', school: 'Berkeley Arts Magnet School'}
]

schools = [
{name:'Berkeley Arts Magnet School', address:'2015 Virginia St, Berkeley, CA 94709', lat:37.876869, lon:-122.270348},
{name:'Emerson Elementary School', address:'2800 Forest Ave, Berkeley, CA 94705', lat:37.861570, lon:-122.251160},
{name:'Jefferson Elementary School', address:'1400 Ada St, Berkeley, CA 94702', lat:37.878910, lon:-122.284420}
]

mentors = [
{name:'Emma Sandoval', school:'Berkeley Arts Magnet School', email:'es@berkeley.edu'},
{name:'Bradley Smythe', school:'Berkeley Arts Magnet School', email:'bs@berkeley.edu'},
{name:'Diana Hansen', school:'Emerson Elementary School', email:'dh@berkeley.edu'},
{name:'Kyler Ochoa', school:'Jefferson Elementary School', email:'ko@berkeley.edu'},
{name:'Joseph Gonzalez', school:'Jefferson Elementary School', email:'jg@berkeley.edu'},
{name:'Stephanie Brooks', school:'Jefferson Elementary School', email:'sb@berkeley.edu'},
{name: 'Nick Ruhman', school: 'Berkeley Arts Magnet School', email: 'nwruhman@berkeley.edu'}
]

reports = [
{type: 'checkin', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', checkin_time: '2019-10-18 13:00:00', lat: 37.876869, lon: -122.270348},
{type: 'checkout', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', checkout_time: '2019-10-18 14:00:00', lat: 37.876869, lon: -122.270348},
{type: 'checkin', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', checkin_time: '2019-10-25 13:00:00', lat: 37.876869, lon: -122.270348},
{type: 'checkout', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', checkout_time: '2019-10-25 14:00:00', lat: 37.876869, lon: -122.270348},

{type: 'checkin', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', checkin_time: '2019-10-24 13:00:00', lat: 37.876869, lon: -122.270348},
{type: 'checkout', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', checkout_time: '2019-10-24 14:30:00', lat: 37.876869, lon: -122.270348},
{type: 'checkin', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', checkin_time: '2019-10-25 13:00:00', lat: 37.876869, lon: -122.270348},
{type: 'checkout', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', checkout_time: '2019-10-25 14:00:00', lat: 37.876869, lon: -122.270348},

{type: 'checkin', mentor: 'Diana Hansen', school: 'Emerson Elementary School', checkin_time: '2019-10-18 13:00:00', lat: 37.861570, lon: -122.251160},
{type: 'checkout', mentor: 'Diana Hansen', school: 'Emerson Elementary School', checkout_time: '2019-10-18 14:00:00', lat: 37.861570, lon: -122.251160},

{type: 'checkin', mentor: 'Joseph Gonzalez', school: 'Jefferson Elementary School', checkin_time: '2019-10-25 13:00:00', lat: 37.878910, lon: -122.284420},

{type: 'checkin', mentor: 'Stephanie Brooks', school: 'Jefferson Elementary School', checkin_time: '2019-10-24 13:00:00', lat: 37.878910, lon: -122.284420},
{type: 'checkout', mentor: 'Stephanie Brooks', school: 'Jefferson Elementary School', checkout_time: '2019-10-24 14:30:00', lat: 37.878910, lon: -122.284420},
{type: 'checkin', mentor: 'Stephanie Brooks', school: 'Jefferson Elementary School', checkin_time: '2019-10-25 13:00:00', lat: 37.878910, lon: -122.284420}
]

Report.delete_all
Mentor.delete_all
School.delete_all
Admin.delete_all


schools.each do |school|
  School.create!(school)
end

admins.each do |admin|
  admin[:school] = School.where(name: admin[:school_name]).first
  Admin.create!(admin)
end

mentors.each do |mentor|
  mentor[:school] = School.where(name: mentor[:school]).first
  Mentor.create!(mentor)
end

=begin

reports.each do |check|
  check[:mentor] = Mentor.where(name: check[:mentor]).first
  check[:school] = School.where(name: check[:school]).first
  type = check[:type]
  check.delete(:type)
  if type == 'checkin'
    Checkin.create!(check)
  else
    Checkout.create!(check)
  end
end

=end
