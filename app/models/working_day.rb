class WorkingDay < ActiveRecord::Base
  belongs_to :station, :class_name=>"PConfig::Station"
  belongs_to :user, :class_name=>"PConfig::User",:foreign_key => "operator_id"
  belongs_to :standard, :class_name=>"PConfig::Standard"
  has_many   :working_day_logs
  after_save :add_log
  validates_presence_of :reason  
  
  def add_log
    hash={:product_id=>self.product_id,:working_day_id=>self.id, :reason=>self.reason,
          :delayed_time=>self.delayed_time,:number_piece=>self.number_piece,:status=>self.status,
          :percentage_production=>self.percentage_production,:effective_time=>self.effective_time,
          :description=>self.description,:start_time=>self.start_time,:end_time=>self.end_time,
          :standard_id=>self.standard_id,:station_id=>self.station_id, :average_piece=>self.average_piece,
          :effective_time=>self.effective_time}
    WorkingDayLog.create(hash)
  end
  
  def self.get_working_day(station, current_user_id,product_id=nil)
    if (working_day = WorkingDay.where("status in ('pausa','waiting_active','active') and station_id = ?", station.id ).first).blank?
        avariable=(PConfig::WorkTime.total_hours - PConfig::BootVariable.get_time_sum(station.standard.boot_variables).to_f).utc.strftime("%H:%M:%S")
        working_day = WorkingDay.create(:effective_time=>"00:00:00",:disponible_time=>avariable,:product_id=>product_id,:reason=>'por iniciar',:status=>'waiting_active',:standard_id=>station.standard.id,:station_id=>station.id,:operator_id=>current_user_id)
    end
    if working_day.status == "active"
      working_day.delayed_time = (Time.parse(working_day.calculate_deleyed_works) + working_day.delayed_time.to_f).strftime("%H:%M:%S")
      working_day.save
    end
    return working_day
  end
  
  def calculate_deleyed_works
    time_now = Time.now
    times = (self.start_time + self.effective_time.to_f)
    times = times + self.delayed_time.to_f
    return (time_now - times.to_f).strftime("%H:%M:%S")
  end
  
  def selected_product(hash={})
    self.product_id = hash[:product_id]
    self.save
  end
  
  def start_working_day(hash={})
    #FIXME agergar errores del porque no se puede iniciar
    return false if self.status == "active"
    start_time = Time.now
    work_time = PConfig::WorkTime.first
    #return false if work_time.is_working?
    self.delayed_time = (start_time - work_time.first_hour.to_f).strftime("%H:%M:%S")
    self.start_time    =start_time.strftime("%H:%M:%S")
    self.status       = "active"
    self.reason       = "Se inicio"
    self.description  = "Se inicio"
    self.effective_time = "00:00:00"
    return self.save
  end
  
  def calculate_item_piece(hash)
    self.number_piece = self.number_piece.nullo.if_nil(0) + hash[:number_piece].to_i
    self.effective_time = hash[:time] if self.status == 'active'
    #self.delayed_time = (self.delayed_time.to_time - Time.parse(hash[:cron]).to_f).strftime("%H:%M:%S") if self.status == 'pausa'
    self.percentage_production = self.calcul_percentage
    self.description  = "add item"
    self.average_piece = self.calcul_averenge
    return self.save
  end
  
  def calcul_averenge
    return (Time.new(2000) + (self.get_minutes/self.number_piece).minutes).strftime("%H:%M:%S")
  end
  
  def calcul_percentage
    return (self.number_piece * 100)/self.standard.item_number
  end
  
  def get_minutes
    self.effective_time.min + (self.effective_time.hour * 60)
  end
  
  def get_time_available
    worktime = PConfig::WorkTime.total_hours
    total_boot_variables = PConfig::BootVariable.get_time_sum self.standard.boot_variables
    return (worktime - total_boot_variables.to_f).utc.strftime("%H:%M:%S")
  end
end
