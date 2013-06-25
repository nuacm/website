NUACM::Application.routes.draw do
  # General routes.
  get '/',      :to => 'pages#home',  :as => 'home'
  get '/about', :to => 'pages#about', :as => 'about'

  # Every site needs a playground.
  get '/playground', :to => 'pages#playground', :as => 'playground'

  # Members and Officers.
  resources :members do
    member { put 'change_password' }
  end

  # Password Resets.
  resource :password_reset, :except => [:show, :destroy]

  # Sessions.
  get    'signup'   => 'members#new',      :as => 'signup'
  delete 'logout'   => 'sessions#destroy', :as => 'logout'
  get    'login'    => 'sessions#new',     :as => 'login'
  post   'login'    => 'sessions#create'
end
