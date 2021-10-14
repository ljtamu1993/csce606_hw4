Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  # get 'movies/:id/same_directors', to: 'movies#same_directors', as: 'same_directors'  
  get 'similar/:title',to: 'movies#similar', as: :similar  
end
