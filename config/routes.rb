Rails.application.routes.draw do
  root to: 'visitors#home'
  get '/financiacion', to: 'visitors#financing'
  get '/sobre-nosotros', to: 'visitors#about_us'
  resources :find_car_requests, only: [:new, :create]
end
