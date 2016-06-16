Rails.application.routes.draw do

  root 'home#index'
  get '/about' => 'home#about'

  resources :projects do
    resources :discussions do
      resources :comments, only: [:new, :create, :edit, :destroy, :update]
    end
    resources :tasks
  end

end
