Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  # resources :items
  resources :users, only: [:show,:index]
  resources :images
  resources :destinations
  resources :purchases
  resources :cards, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'cards#pay'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :items do
  #   #Ajaxで動くアクションのルートを作成
  #   collection do
  #     get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
  #     get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
  #   end
  #   member do
  #     post 'buy', to: 'items#buy'
  #     get 'done', to: 'items#done'
  #   end
  # end

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
      get "select_category_index"
      get 'search'
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  # resources :categories, only: [:index] do
  #   member do
  #     get 'parent'
  #     get 'child'
  #     get 'grandchild'
  #   end
  # end

end
