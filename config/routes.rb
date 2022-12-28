
Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :managers, controllers: {
    sessions: 'managers/sessions',
    passwords: 'managers/passwords',
    
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api', module: :api, as: :api do
    scope '/v1', module: :v1 do
      root "home#index"
    end
  end
  
  scope '/', module: :web, as: :web do 
    root "home#index"
    post "/", to: 'home#create'
    post "/webhook", to: 'home#webhook'
  end

  scope '/admin', module: :admin, as: :admin do
    root 'dashboard#index'
    resources :users
    resources :users_groups
    resources :managers
    resources :organizations
    
    require 'sidekiq/web'
    require 'sidekiq-scheduler/web'
    mount Sidekiq::Web => '/sidekiq_web'
    get 'sidekiq', to: 'sidekiq#index'
  end
end
