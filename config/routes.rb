Rails.application.routes.draw do
  root to: 'visitors#home'
  get '/financiacion', to: 'visitors#financing'
  get '/sobre-nosotros', to: 'visitors#about_us'
  resources :find_car_requests, only: [:new, :create]
  resources :blog_posts, only: [:index]

  get '/blog_posts/bienvenido_al_mundo_de_bmw', to: 'blog_posts#bienvenido_al_mundo_de_bmw'
  get '/blog_posts/las_series_de_bmw', to: 'blog_posts#las_series_de_bmw'
end
