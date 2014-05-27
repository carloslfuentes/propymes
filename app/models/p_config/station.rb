require 'net/ping/tcp'
module PConfig
  class Station < ActiveRecord::Base
    has_many    :product_stations, :dependent => :delete_all
    has_many    :products, :through => :product_stations
    
    accepts_nested_attributes_for :product_stations
    
    belongs_to  :standard
    has_many    :users
    has_many    :working_day
    
    validates :ip_station, 
              :presence => true, 
              :uniqueness => true,
              :ip => { :format => :v4 } 
    
    scope :is_enabled, where(:is_enabled=>true)
    def self.rev_ip(host)
      Net::Ping::TCP.new(host, 'http')
    end
  end
end

