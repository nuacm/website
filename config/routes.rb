NUACM::Application.routes.draw do
  get '/', :to => 'pages#home', :as => 'home'

  get '/playground', :to => 'pages#playground', :as => 'playground'
end
