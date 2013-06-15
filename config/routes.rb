NUACM::Application.routes.draw do
  get '/',      to: 'pages#home', :as => 'home'

  # Members and Officers.
  resources :members do
    member { put 'change_password' }
  end

  # Password Resets.
  resource :password_reset, :except => [:show, :destroy]

  # Sessions.
  get    'signup'   => 'members#new',      :as => 'signup'
  get    'login'    => 'sessions#new',     :as => 'login'
  post   'login'    => 'sessions#create',  :as => 'login'
  delete 'logout'   => 'sessions#destroy', :as => 'logout'
end
