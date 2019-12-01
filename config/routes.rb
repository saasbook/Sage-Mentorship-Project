Rails.application.routes.draw do

  #get 'users/root'
  resources :checkins, except: [:index]
  resources :checkouts, except: [:index, :show]

  get 'schools/' => 'schools#_index', :as => 'schools'
  resources :schools, except: [:index]

  get 'supers/' => 'supers#_index', :as => 'supers'
  resources :supers, except: [:index]

  get 'admins/' => 'admins#_index', :as => 'admins'
  resources :admins, except: [:index]

  # for signed-in-user main page

  get 'mentors/' => 'mentors#_index', :as => 'mentors'
  get 'mentors/new' => 'mentors#new', :as => 'new_mentor'
  get 'mentors/:id' => 'mentors#appointment', :as => 'mentor'
  get 'mentors/:id/details' => 'mentors#show', :as => 'mentor_details'
  get 'mentors/:id/attendances' => 'mentors#attendances', :as => 'mentor_attendances'
  resources :mentors, except: [:index, :show, :new]

  #for check in and checkout @Raj
  get 'mentors/:id/get_loc', to: "mentors#get_loc"
  get '/mentors/:id/checkin', to: 'mentors#checkin', as: 'mentor_checkin'
  get '/mentors/:id/checkout', to: 'mentors#checkout', as: 'mentor_checkout'
  get '/mentors/:id/checkin_loc', to: 'mentors#checkin_loc'
  get '/mentors/:id/checkout_loc', to: 'mentors#checkout_loc'

  root :to => 'logins#new'

  # for google_sign_in checks
  get 'login', to: 'logins#new'
  get 'login/create', to: 'logins#create', as: :create_login

  # for log out
  delete '/logout',  to: 'logins#destroy'
  resource :session

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
