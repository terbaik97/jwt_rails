Rails.application.routes.draw do
  # resources :templates
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :users , only: [:create,:show]
  post  "/login" , to: "users#login"
  get   "/auto_login", to: "users#auto_login"
end
