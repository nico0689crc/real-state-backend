Rails.application.routes.draw do
  resources :property_media
  
  mount_devise_token_auth_for 'User', at: 'auth'
  
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :admin do
        resources :properties
      end

      namespace :public do
        resources :properties, only: [:index, :show]
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
