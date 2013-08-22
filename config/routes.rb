NUACM::Application.routes.draw do
  # General routes.
  get '/',      :to => 'pages#home',  :as => 'home'
  get '/about', :to => 'pages#about', :as => 'about'

  # Event routes.
  resources :events

  # Post routes.
  resources :posts

  # Member routes.
  resources :members do
    member { put 'change_password' }
  end

  # Password Resets.
  resource :password_reset, :except => [:show, :destroy]

  # Session routes.
  get    'signup'   => 'members#new',      :as => 'signup'
  delete 'logout'   => 'sessions#destroy', :as => 'logout'
  get    'login'    => 'sessions#new',     :as => 'login'
  post   'login'    => 'sessions#create'

  ### Silly pages.

  # Every site needs a playground.
  get '/playground', :to => 'pages#playground', :as => 'playground'
end
