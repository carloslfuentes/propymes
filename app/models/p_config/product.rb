module PConfig
  class Product < ActiveRecord::Base
    has_many    :product_stations, :dependent => :delete_all
    has_many    :stations, :through => :product_stations
    has_many    :standards
    has_many    :working_days
    
    belongs_to :product_type
    default_value_for :is_enabled, true
    
    scope :for_station, proc{ |ip| joins(:stations).where("stations.ip_station = ?", ip)}
    scope :only_lineal, joins(:product_type).where(:product_types=>{:type_of_production=>'lineal'})
    scope :for_lineal, proc { |type|joins(:product_type).where(:product_types=>{:type_of_production=>type})}
  end
end
