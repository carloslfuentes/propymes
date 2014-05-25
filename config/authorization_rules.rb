authorization do
  
  role :sessions do
    has_permission_on :p_config_user_sessions, :to => :manage
  end
  
  role :config_all do
    has_permission_on :p_config_products, :to => :manage
    has_permission_on :p_config_product_typess, :to => :manage
    has_permission_on :p_config_standards, :to => :manage
    has_permission_on :p_config_stoppage_by_categories, :to => :manage
    has_permission_on :p_config_stoppages, :to => :manage
    has_permission_on :p_config_user, :to => :manage
    has_permission_on :p_config_boot_variables, :to => :manage
    has_permission_on :p_config_stations, :to => :manage
    has_permission_on :configurations, :to => :manage
  end
  
  role :system do
    includes :config_all
    includes :default
    has_permission_on :authorization_rules, :to => :read
    has_permission_on :p_config_user_sessions, :to => :manage
  end
  
  role :default do
    has_permission_on :home, :to => :manage
    includes :sessions
  end
  
  role :guest do
    includes :sessions
  end
  
end
privileges do
  privilege :manage do
    includes :create, :update, :dstroy
  end
  privilege :manage, :p_config_user_sessions,:includes =>[:create_session, :new, :destroy_session]
  privilege :manage, :p_config_products,:includes =>[:index, :new, :edit, :show]
  privilege :manage, :p_config_product_typess,:includes =>[:index, :new, :edit, :show]
  privilege :manage, :p_config_standards,:includes =>[:index, :new, :edit, :show]
  privilege :manage, :p_config_stoppage_by_categories,:includes =>[:index, :new, :edit, :show]
  privilege :manage, :p_config_stoppages,:includes =>[:index, :new, :edit, :show]
  privilege :manage, :p_config_user,:includes =>[:index, :new, :edit, :show]
  privilege :manage, :p_config_stations,:includes =>[:index, :new, :edit, :show]
  privilege :manage, :p_config_boot_variables,:includes =>[:index, :new, :edit, :show]
  
  privilege :manage, :configurations,:includes =>[:index,:home,:add_permissions_user,:create_permission_user]
  privilege :manage, :home,:includes =>[:index, :operator, :manager, :validate_status]
end