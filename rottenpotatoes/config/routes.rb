Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'same_dir/:title',to: 'movies#same_dir', as: :same_dir
end