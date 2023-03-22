# frozen_string_literal: true

Rails.application.routes.draw do
  resources :guide_cards
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root static("placeholder.html")
  get '/', to: redirect('placeholder.html')
end
