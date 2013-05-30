Trax::Application.routes.draw do

  root to: 'user#login'

  match 'login' => 'user#login', as: :user_login, via: [ :get, :post ]
  match 'logout' => 'user#logout', as: :user_logout, via: [ :get ]
  match 'signup' => 'user#signup', as: :user_signup, via: [ :get, :post ]

  get 'dashboard' => 'dashboard#index', as: :dashboard

  resources :tracks

end
