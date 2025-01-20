Rails.application.routes.draw do
  get "up",             to: "rails/health#show",        as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest",       to: "rails/pwa#manifest",       as: :pwa_manifest

  root "posts#index"

  resources :posts, only: %i[index show]

  namespace :admin do
    root "posts#index"

    resources :posts, only: %i[new create edit update destroy] do
      post :preview, on: :collection
    end
  end

  get "feed.atom", to: redirect("posts.atom")
end
