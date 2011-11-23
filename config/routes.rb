Citysandbox::Application.routes.draw do

  root :to => 'home#splash', :as => :home
  root :to => 'home#splash', :as => :root
  
  scope :as => :home do
    get  '/' => 'home#splash', :as => :splash
    get '/login' => 'sessions#new', :as => :login
    get '/logout' => 'sessions#destroy', :as => :logout
    get '/register' => 'users#new', :as => :register
  end
  
  resources :sessions
  
  match "/vote" => "proposals#vote"
  match "/edit_profile" => "users#edit"
  match "/follow" => "discussion#follow"
  match "/unfollow" => "discussion#unfollow"
  match "/recent" => "users#recent"
  match "/qr" => 'discussion#qr'
  match "/map_info" => 'map#get_info'
  match "/users/profile/:id" => 'users#profile'
  
  resources :questions do
    resources :response_questions, :shallow => true
    resources :challenges, :shallow => true
    resources :events, :shallow => true
  end
  
  resources :events do
    resources :response_events, :shallow => true
  end

  resources :challenges do
    resources :response_challenges, :shallow => true
    resources :proposals, :shallow => true
    resources :events
  end
  
  resources :discussion do
    get '/' => 'discussion#summary', :as => :summary
  end

  get '/summary' => 'discussion#summary', :as => :summary
  get '/filter' => 'discussion#filter', :as => :filter
  
  match "/map" => 'map#index', :as => :map
  
  match "messages/sent" => "sent#show"
  match "messages/inbox" => "inbox#show"
  match "messages/new" => 'inbox#new'
  match "messages/create" => "inbox#create"
  
  # match "users/inbox/new" => "inbox#new"
  match "messages/reply/:id" => "inbox#respond", :as => :reply
  match "messages/send_to/:id" => "inbox#send_to", :as => :reply
  
  resources :users, :messages,  :inbox
  
  # scope "/users" do
  #   resources :mailbox
  #   resources :sent
  # end
  
  # resources :inbox do
  #     get '/index' => 'inbox#index', :controller => "inbox", :action => "index"
  # 
  #     member do
  #       get 'respond'
  #     end
  #   end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with response_url(:id => response.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
