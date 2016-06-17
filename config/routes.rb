Rails.application.routes.draw do

  root 'home#index'
  get '/about' => 'home#about'

  resources :users, only: [:new, :create]
  resources :projects do
    resources :discussions do
      resources :comments, only: [:new, :create, :edit, :destroy, :update]
    end
    resources :tasks
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
