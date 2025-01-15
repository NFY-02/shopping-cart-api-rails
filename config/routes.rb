Rails.application.routes.draw do
  root "products#index"

  resources :products, only: [ :index ]
  get "/cart", to: "products#cart", as: :cart
  post "/add_to_cart", to: "cart#add_to_cart", as: :add_to_cart

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
