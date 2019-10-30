Rails.application.routes.draw do
  resources :checkouts
  resources :checkins
  resources :admins
  resources :schools
  resources :mentors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/admin/checkin', to: 'admins#checkin', as: 'admin_checkin'
  get '/mentor/checkin', to: 'mentors#checkin', as: 'mentor_checkin'
  get '/mentor/checkout', to: 'mentors#checkout', as: 'mentor_checkout'

  root :to => redirect('/mentor/checkin')
end
