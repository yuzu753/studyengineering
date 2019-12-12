Rails.application.routes.draw do
  root 'tops#top'

  devise_for :users

  resources :tops, only: [:top, :privacy]
  get 'tops/top', to: 'tops#top'
  get 'tops/privacy', to: 'tops#privacy'

  resources :users, only: [:show, :edit, :update, :destroy]

  resources :books, { only: [:show, :create] } do
  	collection do
  		get :search
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
