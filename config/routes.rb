Rails.application.routes.draw do

  #get 'users/root'
  resources :checkouts
  resources :checkins
  resources :admins
  resources :schools

  # for signed-in-user main page
  get 'mentors/:id' => 'mentors#index', :as => 'mentor'
  get 'mentors/:id/details' => 'mentors#show', :as => 'mentor_details'
  resources :mentors, except: [:index, :show]

  # for google_sign_in checks
  get 'login', to: 'logins#new'
  get 'login/create', to: 'logins#create', as: :create_login



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/admin/checkin', to: 'admins#checkin', as: 'admin_checkin'
  get '/mentor/checkin', to: 'mentors#checkin', as: 'mentor_checkin'
  get '/mentor/checkout', to: 'mentors#checkout', as: 'mentor_checkout'

  root :to => 'logins#new'
  #
  #root :to => redirect('/mentor/checkin')
  #get 'mentors/:id', to: 'checkins#mentors'
  #root :to => 'checkins#index'

end
