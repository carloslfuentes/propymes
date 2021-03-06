PROPYMES::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  match 'home/' => 'home#index'
  match 'home/operator' => 'home#operator', :as => "operator", :via => :get
  match 'home/manager' => 'home#manager', :as => "manager", :via => :get
  match 'user_sessions/' => 'p_config/user_sessions#new'
  
  #home
  resources :home do
    collection do
      get :validate_status
      post :timer_actions
      post :add_items
      post :timers
      get :change_product
      get :select_graph
    end
  end
  
  root :to => "p_config/user_sessions#new"
  resources :configuration_mailers
  resources :configuration_values
  
  #Configurations
  namespace :p_config do
    resources :line_sets
    resources :standard_types
    resources :fixed_amounts
    resources :products do 
      resources :standards
    end
    resources :standards
    resources :stations do
      collection do
        get :comprovate_ip
        get :change_status
      end
      member do
        get :choose_products
      end
    end
    resources :users do
      collection do
        get :get_permission_selected
        get :get_assosiate_assitant
      end
    end
    resources :user_sessions do
      collection do
        post :new
        post :create_session
        get :destroy_session
        get :heartbeat
      end
    end
    resources :boot_variables
    resources :product_types
    resources :stoppages
    resources :stoppage_by_categories
    resources :work_times
    resources :reasons
    resources :inputs
    resources :events
  end
  resources :configurations do
    collection do
      get :home
    end
  end
  
end
