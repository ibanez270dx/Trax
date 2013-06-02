Trax::Application.routes.draw do

  root to: 'users#login'

  match 'login' => 'users#login', as: :user_login, via: [ :get, :post ]
  match 'logout' => 'users#logout', as: :user_logout, via: [ :get ]
  match 'signup' => 'users#signup', as: :user_signup, via: [ :get, :post ]

  get 'dashboard' => 'dashboard#index', as: :dashboard
  get 'dashboard/update' => 'dashboard#update', as: :update_dashboard

  resources :tracks

end
