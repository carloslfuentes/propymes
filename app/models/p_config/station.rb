require 'net/ping/tcp'
module PConfig
  class Station < ActiveRecord::Base
    belongs_to :product
    belongs_to :standard
    has_many :users
    
    validates :ip_station, 
              :presence => true, 
              :uniqueness => true,
              :ip => { :format => :v4 } 
    scope :is_actived, where(:is_enabled=>true)
    def self.rev_ip(host)
      Net::Ping::TCP.new(host, 'http')
    end
  end
end

