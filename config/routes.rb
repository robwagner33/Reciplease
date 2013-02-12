Reciplease::Application.routes.draw do
  resources :recipes
  match 'recipes/:id/:name' => 'recipes#show'

  resources :ratings, :only => [:create, :update, :destroy]
  
  authenticated :user do
    root :to => 'home#home'
  end
  
  root :to => "home#welcome"
  devise_for :users
  resources :users
end
