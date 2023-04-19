Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/health_check', to: proc { [200, {}, ['success']] }
      post 'login',  to: 'sessions#create'
      get  'profile',to: 'sessions#profile'
    end
  end
end