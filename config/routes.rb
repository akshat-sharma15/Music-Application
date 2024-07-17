Rails.application.routes.draw do
  require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  #users
  get "users", to: "user_profiles#allusers"
  put "user/update", to: "user_profiles#update"
  get "user", to: "user_profiles#show"
  delete "user/delete/:id", to:"user_profiles#delete"
  
  #songs 
  get "song/:id", to: "songs#show"
  get "songs", to: "songs#allsongs"
  put "song/update/:id", to: "songs#update"
  post "song/new", to: "songs#create"
  delete "song/delete/:id", to: "songs#delete"

  #playlist
  post 'playlists/:id/add_songs', to: 'playlists#add_songs'
  post "playlist/new", to: "playlists#create"
  get "playlists", to: "playlists#all_playlists"
  get "playlist/:id", to: "playlists#show"
  put "playlist/:id", to: "playlists#update"
  delete "playlist/:id", to: "playlists#delete"

  #artist
  post "artist", to: "artists#create"
  get "artists", to: "artists#artists"
  get "artist/:id", to: "artists#show"
  put "artist/:id", to: "artists#update"
  delete "artist/:id", to: "artists#delete"
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
