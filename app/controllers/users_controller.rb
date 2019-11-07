class UsersController < ApplicationController
  attr_reader :name, :content
  def root
    @name = "google-signin-client_id"
    @content = "874482834971-lqadmntua28ak3td8hkktbgphjheitnu.apps.googleusercontent.com"
  end
end
