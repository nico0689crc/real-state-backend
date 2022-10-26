Rails.application.routes.draw do
  constraints subdomain: 'real-estate-api' do
    resources :property_attributes

    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations:  'overrides/registrations',
      sessions:  'overrides/sessions',
    }
    
    namespace :api, defaults: {format: :json} do
      namespace :v1 do
        namespace :admin do
          resources :properties do
            resources :medias, only: [:delete] do
              delete :destroy, to: "properties#medias_destroy", on: :member
            end
          end

          resources :users do
            patch :update_password, on: :member
          end
        end

        namespace :public do
          resources :properties, only: [:index, :show]
        end
      end
    end
  end
end
