module PConfig
  class Product < ActiveRecord::Base
    has_many    :product_stations, :dependent => :delete_all
    has_many    :stations, :through => :product_stations
    
    belongs_to :product_type
    default_value_for :is_enabled, true
    
    scope :for_station, proc{ |ip| joins(:stations).where("stations.ip_station = ?", ip)}
  end
end
