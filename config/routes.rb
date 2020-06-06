Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items
  resources :destinations
  resources :cards, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'cards#pay'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
