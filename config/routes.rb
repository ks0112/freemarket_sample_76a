Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  # resources :items
  resources :users, only: :show
  resources :images
  resources :destinations
  resources :cards, only: [:new, :show, :destroy] do
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items do
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      post 'buy', to: 'items#buy'
      get 'done', to: 'items#done'
    end
  end

end
