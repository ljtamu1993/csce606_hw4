Rails.application.routes.draw do
  root 'movies#index'
  resources :movies
  # map '/' to be a redirect to '/movies'
  # root :to => redirect('/movies')
  get 'same_dir/:title',to: 'movies#same_dir', as: :same_dir
end
