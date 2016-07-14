Rails.application.routes.draw do

  get '/auth/github', as: :sign_in_with_github
  get '/auth/github/callback' => "callbacks#github"

  root 'home#index'
  get '/about' => 'home#about'

  resources :users, only: [:new, :create, :edit, :update]
  get '/change_password' => 'users#change_password'
  patch '/change_password' => 'users#update_password'

  resources :projects do
    resources :discussions do
      resources :comments, only: [:new, :create, :edit, :destroy, :update]
    end
    resources :tasks
    resources :favorites, only: [:create, :destroy]
  end

  resources :favorites, only: [:index]

  resources :sessions, only: [:new, :create, :edit, :update] do
    delete :destroy, on: :collection
  end

  resources :password_resets, only: [:new, :create, :edit, :update]
end
