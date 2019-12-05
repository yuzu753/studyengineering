Rails.application.routes.draw do
  root 'tops#top'

  devise_for :users

  resources :tops, only: [:top]
  get 'tops/top', to: 'tops#top'

  resources :users, only: [:show, :edit, :update, :destroy]

  resources :books, { only: [:show, :create, :update, :destroy] } do
  	collection do
  		get :search
  		get :result
  	end
  end

  resources :recommendeds, only: [:create, :destroy]

  resources :todolists, only: [:index, :edit, :create, :update]

  resources :records, only: [:index, :edit, :create, :update]

end
