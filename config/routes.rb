NUACM::Application.routes.draw do
  get '/',      to: 'pages#home', :as => 'home'

  post 'forgot-password', to: 'members#forgot_password', :as => 'forgot_password'
end
