Rails.application.routes.draw do
  devise_for :users
  #devise_for :users, controllers: {registrations: :my_registration}
  root to: "posts#index"

  resources :posts do
    resources :comments
    resources :likes
  end
end
