# Sage-Mentorship-Project

## Scaffolding
First step is to get a ruby version manager package:
  ```
  $ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E37D2BAF1CF37B13E2069D6956105BD0E739499BDB
  $ \curl -sSL https://get.rvm.io | bash -s stable
  ```
## Setting Up Ruby
Required Ruby version: ruby '>=2.4.7' for example you can use ruby 2.5.1 as follows.
  ```
  $ rvm install 2.5.1
  $ rvm use 2.5.1
  $ ruby -v
  ```
You can also set up the default version of ruby:
  ```
  $ rvm --default use 2.5.1
  ```
## Once you have all the environment set up correctly you can run
* Clone the repository
* Run the command below to install the dependencies 
  ```
  $ bundle install --without production
  ```
## Seed the databse
* In order to run it locally first run the command to seed the database and set up the tables
* If you want the app to behave as super or admin  or mentor, you can go to db/seeds.rb and add 
  your credentials on the list that's there, this will create a db entry once you run the command below
  and will give you access to certain user type that you added your credentials on the file.
  ```
  $ bundle exec rake db:setup
  ```
## Run the server
* Once you have all the gem installed and db setup use the command to run the server locally
  ```
  $ rails serveer
  ```
  

## Export to xml file
* Gem that was used to export the records from the database to xml file is 'axlsx_rails'.
  Link to documentation: https://github.com/caxlsx/axlsx_rails.
  Implementation is done in mentor views _index.xlsx.axlsx file that gets called when the 
  request asks to render xlsx format.

* For future students: For some reason the active record join method didn't work while joining 
  Checkin and Checkout table so we had to make raw sql query to join those two tables to generate 
  the reports.

## Geolocation
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

## Google sign in
* gem 'google_sign_in' is used to simplify the process of implementing google sign in feature, which also 
  includes calnet authentication since calnet is through gmail.
* documentation for 'google_sign_in' gem can be found at: https://github.com/basecamp/google_sign_in
* A google developer api key is required for this and will be controlled through Sage Mentorship personnel. 
  - See "configure a project"   link here: https://developers.google.com/identity/sign-in/web/sign-in
  - Upon configuring a project, you must also link the intended website homepage domain and callback url.

## Database Relations
* There are 6 tables total. All the relations are indexed at ID. More information about tables are in schema file.

* Schools : School has hasmany relation with checkin, checkout, mentors and the relation is dependent destroy. 
  School has one to one relation with admins.

* Mentors : Mentors has hasmany relation with checkin, chekout and the relation is dependent destroy. 
  Mentor belogs to School. 

* Admins : Belongs to school. Used to store credentials of admins.

* Checkins, Checkouts: The two tables belongs to Mentors.

* Super: It is used to store credentials of super user. Super user are the user that has all the controls to the app 
  including deleting, adding, editing schools, admins, mentors, checkins and checkouts.

## Encryption
* You will need encryption key inorder to decrypt the key config/application.yml.asc file that has google api key and other
  credential to run this app. GSI or course staff will have this key. Please refer to them.

* Once you have that key, you can run the command below to decrypt the key, be sure to add the decrypted file in your gitignore.
```
 $export KEY=your-secret-key-value 
 $gpg --passphrase "$KEY" --decrypt \
 $--output config/application.yml config/application.yml.asc
```

* 'Figaro' gem is used along with this encrypted application file in order to use the keys throughout the application.

## User access rights
* Super: 
  - see all mentor data
  - see all school data
  - see all admin data
  - see all super user data
  - create, edit, destroy all of the above user types
  - export checkin data to csv file and reset checkin/checkout tables
* Admin: 
  - see all mentor checkins for their school only
  - able to created, edit, delete mentors
  - able to create, edit, delete check in for particular mentor
  - able to create, edit, delete check out for particular mentor
  - able to mark checkin and checkout geolocation as valid/invalid. Default range for 'valid' status is 0.25mi from a school.
* Mentor:
  - able to check out and check in to their mentorship assignment
  
## Note
* Currently the app is deployed in heroku and the link to app is https://rocky-tundra-90969.herokuapp.com/, though in future 
  i believe it will be deployed to somewhere else. By default rails uses sqlite as db but heroku doesn't support sqlite, so we have
  set up the postgress sql for heroku according to it's standard. The documentation can be found in heroku website.

[![Maintainability](https://api.codeclimate.com/v1/badges/c74672e4ce0deb8f6fbf/maintainability)](https://codeclimate.com/github/Sage-Foundation-Mentorship/Sage-Mentorship-Project/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/c74672e4ce0deb8f6fbf/test_coverage)](https://codeclimate.com/github/Sage-Foundation-Mentorship/Sage-Mentorship-Project/test_coverage)

[![Build Status](https://travis-ci.com/Sage-Foundation-Mentorship/Sage-Mentorship-Project.svg?branch=master)](https://travis-ci.com/Sage-Foundation-Mentorship/Sage-Mentorship-Project)
