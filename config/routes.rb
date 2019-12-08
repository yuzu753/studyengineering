Rails.application.routes.draw do
  root 'tops#top'

  devise_for :users

  resources :tops, only: [:top]
  get 'tops/top', to: 'tops#top'

  resources :users, only: [:show, :edit, :update, :destroy]

  resources :books, { only: [:create] } do
  	collection do
  		get :search
  		get :result
      get :detail
  	end
  end

  resources :bookshelves, only: [:create, :update, :destroy]

  resources :recommendeds, only: [:create, :destroy]

  resources :todolists, only: [:index, :edit, :create, :update, :destroy] do
    patch :congratulations
  end

  resources :records, only: [:index, :edit, :create, :update]

end
