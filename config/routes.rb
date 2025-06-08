Rails.application.routes.draw do
  get 'home/redirect_user'
  get "up" => "rails/health#show", as: :rails_health_check
  
  root to: "home#redirect_user"
  
  devise_for :users

  namespace :client do
    resources :dashboard, only: [:index]
    resources :documents, only: [:index, :new, :create, :show]
  end

  namespace :data_entry_operator do
    resources :documents, only: [:index, :show] do
      member do
        patch :verify
      end
    end
  end

  namespace :supervisor do
    resources :documents, only: [:index, :show] do
      member do
        patch :verify
      end
    end
  end

  namespace :manager do
    get 'dashboard/index'
  end

  namespace :super_admin do
    get "dashboard", to: "dashboard#index"
    resources :users, only: [:index, :edit, :update]
  end

end
