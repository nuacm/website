NUACM::Application.routes.draw do
  get '/',      to: 'pages#home', :as => 'home'

  resources :members
  get    'signup'   => 'members#new',      :as => 'signup'
  get    'login'    => 'sessions#new',     :as => 'login'
  post   'sessions' => 'sessions#create',  :as => 'sessions'
  delete 'logout'   => 'sessions#destroy', :as => 'logout'
end
