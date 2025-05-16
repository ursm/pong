Rails.application.routes.draw do
  root "posts#index"

  resources :posts, only: :show
  resource  :feed,  only: :show

  namespace :admin do
    root "posts#index"

    resources :posts, only: %i[new create edit update destroy] do
      post :preview, on: :collection
    end

    mount Litestream::Engine, at: "/litestream"
  end

  get "posts.atom", to: redirect("feed.atom")

  get "up",             to: "rails/health#show",        as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest",       to: "rails/pwa#manifest",       as: :pwa_manifest
end
