Citysandbox::Application.routes.draw do

  get "mailbox/show"

  get "messages/show"

  get "sent/index"

  get "sent/show"

  get "sent/new"
  
  root :to => 'home#splash', :as => :home
  root :to => 'home#splash', :as => :root
  
  scope :as => :home do
    get  '/' => 'home#splash', :as => :splash
    get '/login' => "sessions#new", :as => :login
    get "/logout" => "sessions#destroy", :as => :logout
    get  '/register' => 'users#new', :as => :register
  end
  
  resources :questions do
    resources :responses, :shallow => true
    resources :challenges, :shallow => true do
      resources :proposals, :shallow => true 
    end
    resources :events, :shallow => true
  end
  
  resources :users, :sent, :messages, :mailbox, :inbox
  
  resources :mailbox do
    get '/index' => 'mailbox#index', :controller => "mailbox", :action => "index"
    get '/display' => 'mailbox#display', :controller => "mailbox", :action => "display"
  end
  
  resources :sent do
    get '/index' => 'sent#index', :controller => "sent", :action => "index"
    get '/create' => 'sent#create', :controller => "sent", :action => "create"
  end
  
  resources :inbox do
    get '/index' => 'inbox#index', :controller => "inbox", :action => "index"

    member do
      get 'respond'
    end
  end
  
  
  resources :sessions
  resources :questions
  resources :challenges
  resources :responses
  resources :discussion do
    get '/summary' => 'discussion#summary', :as => :summary
    get '/' => 'discussion#summary', :as => :summary
  end



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
