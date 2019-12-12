# Sage-Mentorship-Project
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# Export to xml file
* Gem that was used to export the records from the database to xml file is 'axlsx_rails'.
  Link to documentation: https://github.com/caxlsx/axlsx_rails.
  Implementation is done in mentor views _index.xlsx.axlsx file that gets called when the 
  request asks to render xlsx format.

* For future students: For some reason the active record join method didn't work while joining 
  Checkin and Checkout table so we had to make raw sql query to join those two tables to generate 
  the reports.

# Geolocation
* Right now the application gets the geolocation using javascript that gets called when user clicks 
  checkin or checkout button. Once the user clicks any of those two buttons, javascript get's the 
  location from user browser which was accurate than any other gems that we tried because it's being 
  generated from user real location instead of server side location. After getting the location, 
  we hardcoded to generate the redirect url to checkin_loc/checkout_loc in mentor controller with the 
  location parameters(check assets/javascripts/application.js). If the checkin and checkout are valid 
  and saved succesfully it get's redirected to mentor_path page with appropriate flash message.
  (This way, JS also masked the parameter if lat and lon for anypossible bypass)
  We also used geocoder gem to convert the address of the school into cordinates before storing them 
  into the tables when new school is being created for latet purpose to check if the checkin/checkout 
  is valid or invalid. This is implemented in school model convert_location method.

* For future students: Right now we hardcoded the url in JS to call the method checkin_loc/checkout_loc 
  in mentor controller and there is an issue of this app generating # at the end of url sometimes. It would 
  be nice to replace the redirect calls in JS using path helper rails path helper. 

# Database Relations
* There are 7 tables total. All the relations are indexed at ID. More information about tables are in schema file.

* Schools : School has hasmany relation with checkin, checkout, mentors and the relation is dependent destroy. 
  School has one to one relation with admins.

* Mentors : Mentors has hasmany relation with checkin, chekout and the relation is dependent destroy. 
  Mentor belogs to School. 

* Admins : Belongs to school. Used to store credentials of admins.

* Checkins, Checkouts: The two tables belongs to Mentors.

* Super: It is used to store credentials of super user. Super user are the user that has all the controls to the app 
  including deleting, adding, editing schools, admins, mentors, checkins and checkouts.



[![Maintainability](https://api.codeclimate.com/v1/badges/c74672e4ce0deb8f6fbf/maintainability)](https://codeclimate.com/github/Sage-Foundation-Mentorship/Sage-Mentorship-Project/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/c74672e4ce0deb8f6fbf/test_coverage)](https://codeclimate.com/github/Sage-Foundation-Mentorship/Sage-Mentorship-Project/test_coverage)

[![Build Status](https://travis-ci.com/Sage-Foundation-Mentorship/Sage-Mentorship-Project.svg?branch=master)](https://travis-ci.com/Sage-Foundation-Mentorship/Sage-Mentorship-Project)


