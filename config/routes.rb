Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/health_check', to: proc { [200, {}, ['success']] }
      post 'login',  to: 'sessions#create'
      get  'profile',to: 'sessions#profile'

      post 'direct_uploads' , to: 'direct_uploads#create'
      jsonapi_resources :posts
      jsonapi_resources :tags

      namespace :public do
        jsonapi_resources :posts
        jsonapi_resources :tags
      end
    end
  end
end
