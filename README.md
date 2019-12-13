# Sage-Mentorship-Project

## Scaffolding
First step is to ger a ruby version manager package:
```
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E37D2BAF1CF37B13E2069D6956105BD0E739499BDB
$ \curl -sSL https://get.rvm.io | bash -s stable
```
### Setting Up Ruby
```
$ rvm install 2.5.1
$ rvm use 2.1.1
$ ruby -v
```
You can also set up the default version of ruby:
```
$ rvm --default use 2.5.1
```
##### Create an RVM gemset
To keep your gems together, you can create gemsets. You can use use one gemset per project. Here’s how you do that.
```
$ rvm gemset create my_cool_app
ruby-2.5.1 - #gemset created /Users/cezar/.rvm/gems/ruby-2.5.1@my_cool_app
ruby-2.5.1 - #generating my_cool_app wrappers........
```
And to use that gemset you use this.
```
$ rvm 2.5.1@my_cool_app
Using /Users/cezar/.rvm/gems/ruby-2.5.1 with gemset my_cool_app
```

#### Install Rails:
```
$ cd ~/Work
$ rvm use 2.5.1@my_cool_app --create
$ gem install rails
```

### Create new project

Follow thre order of the commands:
```
$ rails new my_cool_app --skip-test --skip-bundle --database=postgresql
```

Copy the database config file
```
$ cp config/database.yml config/database.yml.example
```
Don’t forget to add config/database.yml to your .gitignore file.

Install the gems:
```
$ bundle install
```
Migrate the database
You’ll want to run rails ```db:migrate``` at this point so it creates your development and test databases.

### Install RSpec
First thing is to add RSpec. Add the gem to the development and test environments like so.
```
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.7'
end
```
Then, run the ```bundle``` command.
```
$ bundle
$ rails g rspec:install
```

### Adding Cucumber
Go to your Gemfile and add these two lines to the test group. Then run the bundle command again.

```
group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
end
```

You also need to setup Cucumber by generating it’s config files.
```
rails g cucumber:install
```

And to install Cucumber into our project do:
```
$ bundle install
$ rails generate cucumber:install
```

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


