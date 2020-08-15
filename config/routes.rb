Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "combos#index"
  resources :combos, only: [:index, :show] do
    member do
      get :subscribe
    end
  end
  resources :order_groups, only: [:show]
end
