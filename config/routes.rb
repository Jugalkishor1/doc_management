Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  namespace :client do
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
    get 'dashboard/index'
  end

  namespace :manager do
    get 'dashboard/index'
  end

  namespace :super_admin do
    get 'dashboard/index'
  end

  root to: redirect('/users/sign_in')
end
