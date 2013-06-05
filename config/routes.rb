NUACM::Application.routes.draw do
  get '/',      to: 'pages#home', :as => 'home'

  resources :members do
    member { put 'change_password' }
  end
  get    'signup'   => 'members#new',      :as => 'signup'
  get    'login'    => 'sessions#new',     :as => 'login'
  post   'login'    => 'sessions#create',  :as => 'login'
  delete 'logout'   => 'sessions#destroy', :as => 'logout'
end
