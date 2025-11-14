Rails.application.routes.draw do
  root "pages#home"
  
  get '/:slug', to: 'pages#show', constraints: { slug: /(about|contact)/ }, as: :page

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  get "/products/search", to: "products#search", as: :search_products
  get '/:category_name', to: 'categories#show', as: :category
  get '/:category_name/:product_name', to: 'products#show', as: :product
end
