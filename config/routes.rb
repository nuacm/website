NUACM::Application.routes.draw do
  get '/',      to: 'pages#home', :as => 'home'

  resources :members
end
