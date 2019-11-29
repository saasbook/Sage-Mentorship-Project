# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admins = [
{name:'Darain Noveir', email:'bam@sagementorship.org', school_id: 'Berkeley Arts Magnet School'},
{name:'tonite Parija', email:'tonioshikanlu@berkeley.edu', school_id: 'Jefferson Elementary School'},
{name:'Sweta Parija', email:'emerson@sagementorship.org', school_id: 'Emerson Elementary School'},
{name:'Megan Bendicto', email:'jefferson@sagementorship.org', school_id: 'Jefferson Elementary School'},
]

supers = [
{name:'test su', email:'nwruhman@gmail.com'},
{name:'test super', email:'jasmine.yong@berkeley.edu'},
{name:'test superduper', email:'toni.oshikanlu9@gmail.com'},
{name:'sage president', email:'president@sagementorship.org'}
]

schools = [
{name:'Berkeley Arts Magnet School', address:'2015 Virginia St, Berkeley, CA 94709', lat:37.876869, lon:-122.270348},
{name:'Emerson Elementary School', address:'2800 Forest Ave, Berkeley, CA 94705', lat:37.861570, lon:-122.251160},
{name:'Jefferson Elementary School', address:'1400 Ada St, Berkeley, CA 94702', lat:37.878910, lon:-122.284420}
]

mentors = [
{name:'Raj Giri', email:'freedomcomets@berkeley.edu', school: 'Berkeley Arts Magnet School'},
{name:'Emma Sandoval', school:'Berkeley Arts Magnet School', email:'es@berkeley.edu'},
{name:'Bradley Smythe', school:'Berkeley Arts Magnet School', email:'bs@berkeley.edu'},
{name:'Diana Hansen', school:'Emerson Elementary School', email:'dh@berkeley.edu'},
{name:'Kyler Ochoa', school:'Jefferson Elementary School', email:'ko@berkeley.edu'},
{name:'Joseph Gonzalez', school:'Jefferson Elementary School', email:'jg@berkeley.edu'},
{name:'Stephanie Brooks', school:'Jefferson Elementary School', email:'sb@berkeley.edu'},
{name:'Stephanie niu', school:'Jefferson Elementary School', email:'johnsparksljc@gmail.com'},
{name:'Tmentor', school:'Jefferson Elementary School', email:'nwruhman@berkeley.edu'}
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


Mentor.delete_all
Admin.delete_all
Super.delete_all
School.delete_all


schools.each do |school|
  School.create!(school)
end

admins.each do |admin|
  admin[:school_id] = School.where(name: admin[:school_id]).first.id
  Admin.create!(admin)
end

mentors.each do |mentor|
  mentor[:school] = School.where(name: mentor[:school]).first
  Mentor.create!(mentor)
end

supers.each do |super_user|
  Super.create!(super_user)
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
