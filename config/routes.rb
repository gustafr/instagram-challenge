Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"

  #get '/custom_post', controller: :likes, action: :my_method, as: :my_method
  resources :posts do
    resources :comments
    resources :likes
  end
end
