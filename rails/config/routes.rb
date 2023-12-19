# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :api do
    namespace :v1 do
      get "/health_check", to: "health_check#index"
      mount_devise_token_auth_for "User", at: "auth"
      patch "/user/confirmations", to: "confirmations#update"

      namespace :current do
        get "/user", to: "user#me"
        resources :articles, only: %i[index create update show]
      end

      resources :articles, only: %i[index show]
    end
  end
end
