Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'shipping_addresses', to: 'users/registrations#new_shipping_address'
    post 'shipping_addresses', to: 'users/registrations#complete_user'
  end

  root to: "homes#index"

  resources :items  do
    collection do
      get 'get_category_children', defaults: {format: 'json'}
      get 'get_category_grandchildren', defaults: {format: 'json'}
    end
    # 編集用
    member do
      get 'get_category_children', defaults: {format: 'json'}
      get 'get_category_grandchildren', defaults: {format: 'json'}
    end
  end


  resources :users, only: [:index, :show] do
    member do
      get 'logout', 'edit_profile', 'edit_shipping_address', 'update_complete'
      patch 'update_profile', 'update_shipping_address'
    end
    resources :cards, except: [:show, :edit, :update]
  end

end