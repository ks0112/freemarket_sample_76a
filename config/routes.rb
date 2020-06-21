Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  # resources :items
  resources :users, only: [:show,:index]
  resources :images
  resources :destinations
  resources :cards, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'cards#pay'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items do
    resources :purchases, only: [:index] do
      collection do
        get 'done', to: 'purchases#done'
        post 'buy', to: 'purchases#buy'
      end
    end
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
end
