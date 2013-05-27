Trax::Application.routes.draw do

  root to: 'user#login', as: :user_login

  get 'dashboard' => 'dashboard#index', as: :dashboard

end
