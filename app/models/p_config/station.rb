require 'net/ping/tcp'
module PConfig
  class Station < ActiveRecord::Base
    has_many    :product_stations, :dependent => :delete_all
    has_many    :products, :through => :product_stations
    has_many    :line_set_stations, :dependent => :delete_all
    has_many    :line_set, :through => :line_set_stations
    has_many    :working_days
    has_many    :users
    
    accepts_nested_attributes_for :product_stations
    
    has_many    :users
    has_many    :working_days
    has_many    :events
    belongs_to  :standard
    belongs_to  :standard_type
    
    validates :ip_station, 
              :presence => true, 
              :uniqueness => true,
              :ip => { :format => :v4 } 
    
    scope :is_enabled, where(:is_enabled=>true)
    scope :only_lineal, where(:type_of_production=>'lineal')
    scope :only_base, where(:type_of_production=>'batch')
    
    def self.rev_ip(host)
      Net::Ping::TCP.new(host, 'http')
    end
    
    def get_sum_effective_time
      sum_effective="00:00:00"
      self.working_days.pending_change.each do |working_day|
        sum_effective = OperationTimes::Sum.basic(sum_effective,working_day.effective_time.nullo.if_nil("00:00:00"))
      end
      return sum_effective
    end
    
    def rate_graph
      data = []
      self.working_days.pending_change.each do |working_day|
        hash = {}
        hash[:key] = working_day.product.name.to_s
        hash[:values] =[]
        working_day.working_day_logs.each do |log|
          hash[:values] << {:date => (log.effective_time.utc + 6.hour).to_i * 1000, :value => log.number_piece.to_i }
        end
        data << hash
      end
      return data
    end
  end
end

