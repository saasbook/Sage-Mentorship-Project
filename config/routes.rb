Rails.application.routes.draw do


  #get 'users/root'
  resources :checkouts
  resources :checkins
  resources :admins
  resources :schools
  resources :supers

  # for mentors
  resources :mentors, except: [:show]#[:index, :show]#, :edit]
  get 'mentors/:id/' => 'mentors#appointment'
  get 'mentors/:id/get_loc', to: "mentors#get_loc", :as => 'get_mentor_loc'
  get 'mentors/:id/details' => 'mentors#show', :as => 'mentor_details'

  # for google_sign_in checks
  get 'login', to: 'logins#new'
  get 'login/create', to: 'logins#create', as: :create_login

  # for log out
  delete '/logout',  to: 'logins#destroy'
  resource :session

  #for check in and checkout @Raj
  get '/mentors/:id/checkin', to: 'mentors#checkin', as: 'mentor_checkin'
  get '/mentors/:id/checkout', to: 'mentors#checkout', as: 'mentor_checkout'
  get '/mentors/:id/checkin_loc', to: 'mentors#checkin_loc' 
  get '/mentors/:id/checkout_loc', to: 'mentors#checkout_loc' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/admin/checkin', to: 'admins#checkin', as: 'admin_checkin'
  #get '/mentor/checkin', to: 'mentors#checkin', as: 'mentor_checkin'
  #get '/mentor/checkout', to: 'mentors#checkout', as: 'mentor_checkout'

  root :to => 'logins#new'
end
