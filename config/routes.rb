Rails.application.routes.draw do
  devise_for :users
  resources :pins
  get 'tags/:tag', to: 'pins#index', as: :tag
  
  root "pins#index"
end
