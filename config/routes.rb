# frozen_string_literal: true

Rails.application.routes.draw do
  get 'guide_cards/index', to:'guide_cards#index'
  get 'guide_cards/:id', to: 'guide_cards#show'
  resources :guide_cards
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root static("placeholder.html")
  get '/', to: redirect('placeholder.html')
end
