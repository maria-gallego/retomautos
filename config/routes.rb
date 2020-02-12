Rails.application.routes.draw do
  root to: 'visitors#home'
  get '/sobre-nosotros', to: 'visitors#about_us'
end
