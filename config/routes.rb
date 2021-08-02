Rails.application.routes.draw do
  root 'search#index'

  resources :bikes, only: :show do
    resource :booking, only: [:new, :create, :show]
  end
  resources :search, only: :index
end
