NUACM::Application.routes.draw do
  get '/',      to: 'pages#home',  :as => 'home'
  get '/about', to: 'pages#about', :as => 'about'
end
