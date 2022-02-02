Rails.application.routes.draw do
  
  devise_for :users,
             controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}
  
  patch '/users/set_admin/:id', to: 'users#create_admin' 

  get '/adverts/unposted', to: 'adverts#unposted'
  patch '/adverts/unposted/:id', to: 'adverts#approve'
  
  get '/adverts/:advert_id/comments', to: 'comments#index'
  get '/adverts/:advert_id/comments/:id', to: 'comments#show'

  resources :users, :adverts, :comments
end
