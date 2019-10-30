Rails.application.routes.draw do

  get 'mentors/:id', to: 'checkins#mentors'
  root :to => 'checkins#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
