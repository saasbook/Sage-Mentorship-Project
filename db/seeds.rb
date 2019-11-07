# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admins = [
{name:'Darain Noveir', email:'bam@sagementorship.org'},
{name:'Sweta Parija', email:'emerson@sagementorship.org'},
{name:'Megan Bendicto', email:'jefferson@sagementorship.org'}
]

schools = [
{name:'Berkeley Arts Magnet School', address:'2015 Virginia St, Berkeley, CA 94709', latitude:37.876869, longitude:-122.270348, admin:'Darain Noveir'},
{name:'Emerson Elementary School', address:'2800 Forest Ave, Berkeley, CA 94705', latitude:37.861570, longitude:-122.251160, admin:'Sweta Parija'},
{name:'Jefferson Elementary School', address:'1400 Ada St, Berkeley, CA 94702', latitude:37.878910, longitude:-122.284420, admin:'Megan Bendicto'}
]

mentors = [
{name:'Emma Sandoval', email:'es@berkeley.edu', school:'Berkeley Arts Magnet School'},
{name:'Bradley Smythe', email:'bs@berkeley.edu', school:'Berkeley Arts Magnet School'},
{name:'Diana Hansen', email:'dh@berkeley.edu', school:'Emerson Elementary School'},
{name:'Kyler Ochoa', email:'ko@berkeley.edu', school:'Jefferson Elementary School'},
{name:'Joseph Gonzalez', email:'jg@berkeley.edu', school:'Jefferson Elementary School'},
{name:'Stephanie Brooks', email:'sb@berkeley.edu', school:'Jefferson Elementary School'}
]

checks = [
{type: 'checkin', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', checkin_time: '2019-10-18 13:00:00', latitude: 37.876869, longitude: -122.270348},
{type: 'checkout', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', checkout_time: '2019-10-18 14:00:00', latitude: 37.876869, longitude: -122.270348},
{type: 'checkin', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', checkin_time: '2019-10-25 13:00:00', latitude: 37.876869, longitude: -122.270348},
{type: 'checkout', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', checkout_time: '2019-10-25 14:00:00', latitude: 37.876869, longitude: -122.270348},

{type: 'checkin', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', checkin_time: '2019-10-24 13:00:00', latitude: 37.876869, longitude: -122.270348},
{type: 'checkout', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', checkout_time: '2019-10-24 14:30:00', latitude: 37.876869, longitude: -122.270348},
{type: 'checkin', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', checkin_time: '2019-10-25 13:00:00', latitude: 37.876869, longitude: -122.270348},
{type: 'checkout', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', checkout_time: '2019-10-25 14:00:00', latitude: 37.876869, longitude: -122.270348},

{type: 'checkin', mentor: 'Diana Hansen', school: 'Emerson Elementary School', checkin_time: '2019-10-18 13:00:00', latitude: 37.861570, longitude: -122.251160},
{type: 'checkout', mentor: 'Diana Hansen', school: 'Emerson Elementary School', checkout_time: '2019-10-18 14:00:00', latitude: 37.861570, longitude: -122.251160},

{type: 'checkin', mentor: 'Joseph Gonzalez', school: 'Jefferson Elementary School', checkin_time: '2019-10-25 13:00:00', latitude: 37.878910, longitude: -122.284420},

{type: 'checkin', mentor: 'Stephanie Brooks', school: 'Jefferson Elementary School', checkin_time: '2019-10-24 13:00:00', latitude: 37.878910, longitude: -122.284420},
{type: 'checkout', mentor: 'Stephanie Brooks', school: 'Jefferson Elementary School', checkout_time: '2019-10-24 14:30:00', latitude: 37.878910, longitude: -122.284420},
{type: 'checkin', mentor: 'Stephanie Brooks', school: 'Jefferson Elementary School', checkin_time: '2019-10-25 13:00:00', latitude: 37.878910, longitude: -122.284420}
]

Checkin.delete_all
Checkout.delete_all
Mentor.delete_all
School.delete_all
Admin.delete_all


admins.each do |admin|
  Admin.create!(admin)
end

schools.each do |school|
  school[:admin] = Admin.where(name: school[:admin]).first
  School.create!(school)
end

mentors.each do |mentor|
  mentor[:school] = School.where(name: mentor[:school]).first
  Mentor.create!(mentor)
end

checks.each do |check|
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

