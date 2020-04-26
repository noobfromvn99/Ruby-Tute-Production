Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get 'static_pages/home'
  get 'static_pages/help'
  root 'static_pages#home'
  get '/help' => 'static_pages#help'
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
