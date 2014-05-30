module PConfig
  class WorkTime < ActiveRecord::Base
    default_value_for :first_hour, "00:00"
    default_value_for :last_hour, "00:00"
    default_value_for :monday, true
    default_value_for :tuesday, true
    default_value_for :wednesday, true
    default_value_for :thursday, true
    default_value_for :friday, true
    
    #Return total hour
    def self.total_hours
      @work_time = PConfig::WorkTime.first
      return (@work_time.last_hour - @work_time.first_hour.to_f)#.utc.strftime "%H:%M:%S"
    end
    
    def is_working?
      work_time = self
      first_hour = Time.parse(work_time.first_hour.strftime "%H:%M:%S")
      #FIXME agregar una configuracion para poder iniciar antes
      last_hour = Time.parse(work_time.last_hour.strftime "%H:%M:%S") - 15.minutes
      start_time = Time.now
      is_work_time = last_hour > start_time && first_hour < start_time
      return is_work_time && work_time.get_days_working 
    end
    
    def get_days_working
      return self.days[Date.today.wday]
    end
    
    def days
        [sunday, monday, tuesday, wednesday, thursday, friday, saturday]
      end
    
    #Example
    # time = 7683
    # hours = time/3600.to_i
    # minutes = (time/60 - hours * 60).to_i
    # seconds = (time - (minutes * 60 + hours * 3600))
    
  end
end
