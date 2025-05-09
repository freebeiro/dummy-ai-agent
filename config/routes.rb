Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # This will handle displaying the latest conversation or a new one if no ID is specified.
  root "chats#show" 

  # Route for showing a specific conversation, also handled by ChatsController#show
  # This generates conversation_path(conversation)
  resources :conversations, only: [:show], controller: 'chats' do
    # Nested route for creating messages within a specific conversation
    resources :messages, only: [:create], controller: 'chats'
  end
end
