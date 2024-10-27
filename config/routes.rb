Rails.application.routes.draw do
  get "up",             to: "rails/health#show",        as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest",       to: "rails/pwa#manifest",       as: :pwa_manifest

  root "posts#index"

  resources :years, only: :show, param: :year do
    resources :months, only: :show, param: :month do
      resources :days, only: :show, param: :day
    end
  end

  resource :feed, only: %i[show], constraints: { format: :atom }

  namespace :admin do
    root "posts#index"

    resources :posts, only: %i[new create edit update destroy] do
      post :preview, on: :collection
    end
  end

  direct :post do |post|
    year, month, day = post.date.to_s.split("-")

    [ :year_month_day, year_year: year, month_month: month, day: ]
  end
end
