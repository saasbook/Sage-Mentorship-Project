# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admins = [
{name:'Darain Noveir', email:'bam@sagementorship.org', school: 'Berkeley Arts Magnet School'},
{name:'tonite Parija', email:'tonioshikanlu@berkeley.edu', school: 'Jefferson Elementary School'},
{name:'Sweta Parija', email:'emerson@sagementorship.org', school: 'Emerson Elementary School'},
{name:'Megan Bendicto', email:'jefferson@sagementorship.org', school: 'Jefferson Elementary School'},
{name:'Choi Adm', email:'choimanng@gmail.com', school: 'Jefferson Elementary School'}
]

supers = [
{name:'test raj', email:'rajgiri0520@gmail.com'},
{name:'test su', email:'nwruhman@gmail.com'},
{name:'test super', email:'jasmine.yong@berkeley.edu'},
{name:'Choi Sup', email:'choimanng@berkeley.edu'},
{name:'test superduper', email:'toni.oshikanlu9@gmail.com'}
]

schools = [
{name:'Berkeley Arts Magnet School', address:'2015 Virginia St, Berkeley, CA 94709', lat:37.876869, lon:-122.270348},
{name:'Emerson Elementary School', address:'2800 Forest Ave, Berkeley, CA 94705', lat:37.861570, lon:-122.251160},
{name:'Jefferson Elementary School', address:'1400 Ada St, Berkeley, CA 94702', lat:37.878910, lon:-122.284420}
]

mentors = [
{name:'Raj Giri', email:'freedomcomets@berkeley.edu', school: 'Berkeley Arts Magnet School'},
{name:'Raj second', email:'nepal25208@gmail.com', school: 'Berkeley Arts Magnet School'},
{name:'Emma Sandoval', school:'Berkeley Arts Magnet School', email:'es@berkeley.edu'},
{name:'Bradley Smythe', school:'Berkeley Arts Magnet School', email:'bs@berkeley.edu'},
{name:'Diana Hansen', school:'Emerson Elementary School', email:'dh@berkeley.edu'},
{name:'Kyler Ochoa', school:'Jefferson Elementary School', email:'ko@berkeley.edu'},
{name:'Joseph Gonzalez', school:'Jefferson Elementary School', email:'jg@berkeley.edu'},
{name:'Stephanie Brooks', school:'Jefferson Elementary School', email:'sb@berkeley.edu'},
{name:'Tmentor', school:'Jefferson Elementary School', email:'nwruhman@berkeley.edu'},
{name:'Stephanie niu', school:'Jefferson Elementary School', email:'johnsparksljc@gmail.com'},
{name:'Choi Ment', email:'choimangg@gmail.com', school: 'Berkeley Arts Magnet School'}
]

last_Monday = Date.today.monday.last_week.strftime("%Y-%m-%d")
this_Monday = Date.today.monday.strftime("%Y-%m-%d")
this_Tuesday = Date.today.beginning_of_week(:tuesday).strftime("%Y-%m-%d")

reports = [
{type: 'checkin', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', date: last_Monday, time: '13:00:00', checkin_lat: 37.876869, checkin_lon: -122.270348},
{type: 'checkout', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', date: last_Monday, time: '14:00:00', checkout_lat: 37.876869, checkout_lon: -122.270348},
{type: 'checkin', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', date: this_Tuesday, time: '13:00:00', checkin_lat: 37.876869, checkin_lon: -122.270348},
{type: 'checkout', mentor: 'Emma Sandoval', school: 'Berkeley Arts Magnet School', date: this_Tuesday, time: '14:00:00', checkout_lat: 37.876869, checkout_lon: -122.270348},

{type: 'checkin', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', date: this_Monday, time: '13:00:00', checkin_lat: 37.876869, checkin_lon: -122.270348},
{type: 'checkout', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', date: this_Monday, time: '14:30:00', checkout_lat: 37.876869, checkout_lon: -122.270348},
{type: 'checkin', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', date: this_Tuesday, time: '13:00:00', checkin_lat: 37.876869, checkin_lon: -122.270348},
{type: 'checkout', mentor: 'Bradley Smythe', school: 'Berkeley Arts Magnet School', date: this_Tuesday, time: '14:00:00', checkout_lat: 37.876869, checkout_lon: -122.270348},

{type: 'checkin', mentor: 'Diana Hansen', school: 'Emerson Elementary School', date: last_Monday, time: '13:00:00', checkin_lat: 37.861570, checkin_lon: -122.251160},
{type: 'checkout', mentor: 'Diana Hansen', school: 'Emerson Elementary School', date: last_Monday, time: '14:00:00', checkout_lat: 37.861570, checkout_lon: -122.251160},

{type: 'checkin', mentor: 'Joseph Gonzalez', school: 'Jefferson Elementary School', date: this_Tuesday, time: '13:00:00', checkin_lat: 37.878910, checkin_lon: -122.284420},

{type: 'checkin', mentor: 'Stephanie Brooks', school: 'Jefferson Elementary School', date: this_Monday, time: '13:00:00', checkin_lat: 37.878910, checkin_lon: -122.284420},
{type: 'checkout', mentor: 'Stephanie Brooks', school: 'Jefferson Elementary School', date: this_Monday, time: '14:30:00', checkout_lat: 37.878910, checkout_lon: -122.284420},
{type: 'checkin', mentor: 'Stephanie Brooks', school: 'Jefferson Elementary School', date: this_Tuesday, time: '13:00:00', checkin_lat: 37.878910, checkin_lon: -122.284420}
]

Checkin.delete_all
Checkout.delete_all
Mentor.delete_all
Admin.delete_all
Super.delete_all
School.delete_all


schools.each do |school|
  School.create!(school)
end

admins.each do |admin|
  admin[:school] = School.where(name: admin[:school]).first
  Admin.create!(admin)
end

mentors.each do |mentor|
  mentor[:school] = School.where(name: mentor[:school]).first
  Mentor.create!(mentor)
end

supers.each do |super_user|
  Super.create!(super_user)
end

reports.each do |check|
  type = check[:type]
  if type == 'checkin'
    check[:checkin_time] = check[:date] + ' ' + check[:time]
  else
    check[:checkout_time] = check[:date] + ' ' + check[:time]
  end

  check[:mentor] = Mentor.where(name: check[:mentor]).first
  check[:school_id] = School.where(name: check[:school]).first.id
  check.delete(:school)
  #check.delete(:date)
  check.delete(:time)
  check.delete(:type)

  if type == 'checkin'
    Checkin.create!(check)
  else
    Checkout.create!(check)
  end
end
