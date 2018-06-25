Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'

  resources :events
  get '/events/:id/edit', to: 'events#edit'

  resources :organiser
  get '/account', to: 'organiser#show'
  get '/login', to: 'organiser#login'
  post '/login', to: 'organiser#verify'
  get '/logout', to: 'organiser#logout'
  post '/like/', to: 'likes#like'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
