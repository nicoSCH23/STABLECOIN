Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/home", to: "pages#home"
  devise_scope :user do
    authenticated :user do
      root 'pages#home', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/registrations#new', as: :unauthenticated_root
    end
  end

  # get "/onboarding", to: "pages#onboarding"
  # get "/redirect_preferences", to: "pages#redirect_preferences"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :inc_fiat_accounts, only: [:index]
  resources :user_fiat_accounts
  resources :user_stable_accounts
  resources :transactions, only: [:new, :create, :show, :index]

  resources :users do
    resources :user_stable_account, only: [:show, :index, :update]
  end
end
