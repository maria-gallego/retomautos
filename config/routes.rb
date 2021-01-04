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
  get '/tratamiento-datos-personales', to: 'visitors#personal_data_policy'
  resources :find_car_requests, only: [:new, :create]
  resources :blog_posts, only: [:index]
  resources :cars, only: [:edit, :update]
  resources :car_intakes, only: [:new, :create, :index]
  resources :clients, except: [:destroy] do
    collection do
      get :find_client_for_new_process
    end
  end
  resources :car_interests, only: [:create, :destroy]

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
    resources :buy_processes, only: [:index, :show, :create] do
      collection do
        get :successfully_closed_index
        get :unsuccessfully_closed_index
      end
      member do
        put :mark_as_successfully_closed
        put :mark_as_unsuccessfully_closed
      end
    end
    resources :notes, only: [:create, :destroy]
  end

  namespace :admin do
    resources :buy_processes, only: [:index, :show, :create, :update] do
      collection do
        get :successfully_closed_index
        get :unsuccessfully_closed_index
      end
      member do
        put :mark_as_successfully_closed
        put :mark_as_unsuccessfully_closed
      end
    end
  end
end
