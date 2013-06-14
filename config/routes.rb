NUACM::Application.routes.draw do
  get '/',      to: 'pages#home', :as => 'home'

  # Members and Officers.
  resources :members do
    member { put 'change_password' }
  end

  # Sessions.
  get    'signup'   => 'members#new',      :as => 'signup'
  get    'login'    => 'sessions#new',     :as => 'login'
  post   'sessions' => 'sessions#create',  :as => 'sessions'
  delete 'logout'   => 'sessions#destroy', :as => 'logout'

  # Password Resets.
  resource :password_reset
end
