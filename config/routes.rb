Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'shipping_addresses', to: 'users/registrations#new_shipping_address'
    post 'shipping_addresses', to: 'users/registrations#complete_user'
  end

  root to: "homes#index"
  resources :items
  resources :users, only: [:index, :show] do
    member do
      get 'logout', 'edit_profile', 'update_complete'
      patch 'update_profile'
    end
  end

end