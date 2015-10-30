Rails.application.routes.draw do
  devise_for :users
  #devise_for :users, controllers: {registrations: :my_registration}
  root to: "posts#index"

  get '/my_posts', controller: :users, action: :get_my_posts, as: :my_posts

  resources :posts do
    resources :comments
    resources :likes
  end
end
