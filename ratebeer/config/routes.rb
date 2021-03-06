Rails.application.routes.draw do
  resources :styles

  resources :memberships

  resources :beer_clubs

  resources :users

  resources :beers

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  resources :users do
    post 'toggle_suspended', on: :member
  end

  resource :session, only: [:new, :create, :delete]

  resources :beer_clubs

  root 'breweries#index'

  get 'brewerylist', to:'breweries#list'

  get 'ngbeerlist', to:'beers#nglist'

  get 'signup', to: 'users#new'

  get 'signin', to: 'sessions#new'

  delete 'signout', to: 'sessions#destroy'

  get 'beerlist', to:'beers#list'

  resources :places, only:[:index, :show]
  # mikä generoi samat polut kuin seuraavat kaksi
  # # get 'places', to:'places#index'
  # # get 'places/:id', to:'places#show'

  post 'places', to:'places#search'

  #get 'kaikki_bisset', to: 'beers#index'
  #get 'ratings', to: 'ratings#index'
  #get 'ratings/new', to: 'ratings#new'
  #post 'ratings', to: 'ratings#create'

  resources :ratings, only: [:index, :new, :create, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
