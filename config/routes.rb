# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :events, only: [] do
        resources :tickets, only: %i[index] do
          post 'reserve', on: :collection
        end
      end
    end
  end
end
