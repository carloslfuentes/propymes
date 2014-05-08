PROPYMES::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  match 'home/' => 'home#index'
  match 'user_sessions/' => 'user_sessions#new'
  
  resources :time_limits
  
  resources :user_sessions do
    collection do
      post :new
      post :create_session
      get :destroy_session
    end
  end
  
  root :to => "user_sessions#new"
  
  #Configurations
  namespace :configuration do
    resources :configuration_mailers
    resources :configuration_values
    
    resources :products
    resources :standards
    resources :stations
    resources :work_times
    resources :users do
      collection do
        get :get_permission_selected
        get :get_assosiate_assitant
      end
    end
  end
  resources :configurations do
    collection do
      get :home
    end
  end
  
end
