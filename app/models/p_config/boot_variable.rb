module PConfig
  class BootVariable < ActiveRecord::Base
    
    has_many :standard_boot_variables, :dependent => :delete_all
    has_many :standards, :through => :standard_boot_variables
    
    scope :is_enabled, where(:is_enabled=>true)
    
    def self.get_time_sum(times)
      total_time = Time.utc(2000) 
      times.each do |t|
        total_time += t.time.to_f
      end
      return total_time#.utc.strftime "%H:%M:%S"
    end
  end
end
