Rails.application.routes.draw do
  
  devise_for :users,
             controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}
  
  patch '/users/set_role/:id/:role', to: 'users#set_role' 
  #get '/users/get_token', to: 'users#get_token'

  resources :users, :comments
  resources :adverts do
    get :unposted, on: :collection
    post :unposted, on: :member
    resources :comments, only: [:index, :show]
  end

end
