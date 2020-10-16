Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  root to: 'visitors#home'
  get '/financiacion', to: 'visitors#financing'
  get '/sobre-nosotros', to: 'visitors#about_us'
  get '/encontramos-tu-carro', to: 'find_car_requests#new'
  get '/pagos', to: 'visitors#payments'
  get '/gracias', to: 'visitors#after_form_view'
  resources :find_car_requests, only: [:new, :create]
  resources :blog_posts, only: [:index]

  get '/blog_posts/bienvenido_al_mundo_de_bmw', to: 'blog_posts#bienvenido_al_mundo_de_bmw'
  get '/blog_posts/las_series_de_bmw', to: 'blog_posts#las_series_de_bmw'
  get '/blog_posts/las_camionetas_de_bmw', to: 'blog_posts#las_camionetas_de_bmw'
  get '/blog_posts/los_roadster_de_bmw', to: 'blog_posts#los_roadster_de_bmw'
  get '/blog_posts/los_motores_de_bmw', to: 'blog_posts#los_motores_de_bmw'
  get '/blog_posts/los_deportivos_de_bmw', to: 'blog_posts#los_deportivos_de_bmw'
  post '/mercadolibre-callback', to: 'mercadolibre_callbacks#notify'

  resources :client_with_inquiries, only: [] do
    collection do
      post :create_from_financing
      post :create_from_home
    end
  end

  namespace :sales do
    resources :buy_processes, only: [:index, :show]
    resources :notes, only: [:create, :destroy]
  end
end
