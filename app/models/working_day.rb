class WorkingDay < ActiveRecord::Base
  belongs_to :station, :class_name=>"PConfig::Station"
  belongs_to :user, :class_name=>"PConfig::User",:foreign_key => "operator_id"
  belongs_to :standard, :class_name=>"PConfig::Standard"
  belongs_to :product, :class_name=>"PConfig::Product"
  belongs_to :stoppage, :class_name=>"PConfig::Stoppage"
  has_many   :working_day_logs
  after_save :add_log
  validates_presence_of :reason
  default_value_for :effective_time, "00:00:00"
  
  scope :created_today, proc{|date| where(:created_at => date.to_s + " 00:00:00" .. date.to_s + " 23:59:59" ) }
  scope :actives, where("status in ('standby','waiting_active','active')")
  scope :pending_change, where("status in ('standby','pending change','active')")
  
  def add_log
    hash={:product_id=>self.product_id,:working_day_id=>self.id, :reason=>self.reason,
          :delayed_time=>self.delayed_time,:number_piece=>self.number_piece,:status=>self.status,
          :percentage_production=>self.percentage_production,:effective_time=>self.effective_time,
          :description=>self.description,:start_time=>self.start_time,:end_time=>self.end_time,
          :standard_id=>self.standard_id,:station_id=>self.station_id, :average_piece=>self.average_piece,
          :effective_time=>self.effective_time,:cost_production=>self.cost_production,:standard_type_id=>self.standard_type_id,
          :disponible_time=>self.disponible_time,:target_pieces=>self.target_pieces, :stoppage_id => self.stoppage_id}
    WorkingDayLog.create(hash)
  end
  
  def self.get_working_day(station, current_user_id,product_id=nil)
    if (working_day = WorkingDay.actives.where("station_id = ?", station.id ).first).blank?
        #avariable=(PConfig::WorkTime.total_hours - PConfig::BootVariable.get_time_sum(station.standard.boot_variables).to_f).utc.strftime("%H:%M:%S")
        working_day = WorkingDay.create(:effective_time=>"00:00:00",:disponible_time=>nil,#avariable,
                                        :product_id=>product_id,:reason=>'por iniciar',:status=>'waiting_active',
                                        :standard_type_id=>station.standard_type_id,:standard_id=>nil,:station_id=>station.id,:operator_id=>current_user_id)
    end
    return working_day
  end
  
  def calculate_deleyed_works
    time_now = Time.now
    times = self.start_time
    #times = times + self.delayed_time.to_f
    return OperationTimes::Deduct.basic(time_now,times)
  end
  
  def operation_target_piece
    min_dispobible = get_minutes_time(self.disponible_time)
    min_effective = get_minutes_time(Time.parse(self.station.get_sum_effective_time))
    n_pieces = self.number_piece.nullo.if_nil(0)
    i_numbers = self.standard.item_number
    #pieces = i_numbers - n_pieces
    
    return (((min_dispobible - min_effective) * i_numbers)/min_dispobible).round(0) + n_pieces
  end
  
  def selected_product(hash={})
    product = PConfig::Product.find_by_id hash[:product_id]
    if self.status == "standby"
      if (wd =WorkingDay.find_by_station_id_and_product_id(self.station_id, hash[:product_id])).present?
        wd.reason   = "change product"
        wd.description  = "Cambio de producto"
        wd.delayed_time=self.delayed_time
        #wd.effective_time = self.effective_time
        wd.disponible_time = self.disponible_time
        wd.product_id = product.id
        wd.standard_id = product.standards.find_by_standard_type_id(wd.standard_type_id).id
        wd.disponible_time = wd.get_calcule_change_time
        wd.status = "active"
        wd.target_pieces = wd.operation_target_piece
        wd.effective_time = self.effective_time
        self.status = "pending change"
        self.reason   = "change product"
        self.description  = "Cambio de producto"
        self.save
        wd.save
        return wd
      else
        wd = WorkingDay.new
        wd.station_id = self.station_id
        #wd.effective_time = self.effective_time
        wd.standard_type_id = self.standard_type_id
        wd.operator_id = self.operator_id
        wd.delayed_time=self.delayed_time
        wd.start_time=self.start_time
        wd.disponible_time = self.disponible_time
        wd.product_id = product.id
        wd.standard_id = product.standards.find_by_standard_type_id(wd.standard_type_id).id
        wd.disponible_time = wd.get_calcule_change_time
        wd.status = "active"
        wd.reason = "change product"
        wd.target_pieces = wd.operation_target_piece
        wd.effective_time = self.effective_time
        self.status = "pending change"
        self.reason   = "change product"
        self.status = "pending change"
        self.save
        wd.save
        return wd
     end
    end
    self.product_id = product.id
    self.standard_id = product.standards.find_by_standard_type_id(self.standard_type_id).id
    self.save
    return self
  end
  
  def get_calcule_change_time
     avariable=self.disponible_time.utc.strftime("%H:%M:%S")
     boots_variables=PConfig::BootVariable.get_time_sum(self.standard.boot_variables.only_change).utc.strftime("%H:%M:%S")
     return OperationTimes::Deduct.basic(avariable,boots_variables)
  end
  
  def start_working_day(hash={})
    #FIXME agergar errores del porque no se puede iniciar
    start_time = Time.now
    work_time = PConfig::WorkTime.first
    #return false if work_time.is_working?
    if self.status == "waiting_active"
      self.delayed_time = OperationTimes::Deduct.basic(start_time, work_time.first_hour) 
      self.start_time    =start_time.strftime("%H:%M:%S")
      avariable= OperationTimes::Deduct.basic(PConfig::WorkTime.total_hours, hash[:timer]) #(PConfig::WorkTime.total_hours - PConfig::BootVariable.get_time_sum(self.standard.boot_variables.only_start_variable).to_f).utc.strftime("%H:%M:%S")
      self.target_pieces = self.standard.item_number
      self.disponible_time=OperationTimes::Deduct.basic(avariable,self.delayed_time)
    end
    if self.status == "active" || self.status == "standby"
      fdt = OperationTimes::Deduct.basic(self.start_time,work_time.first_hour)
      dl = OperationTimes::Deduct.basic(self.calculate_deleyed_works,self.effective_time)
      self.status       = "active"
      self.delayed_time = OperationTimes::Sum.basic(fdt,dl)
      self.reason       = "Se Reinicio"
      self.description  = self.status == "standby" ? "Se reinicio" : "Se cerro la ventana"
      self.disponible_time=OperationTimes::Deduct.basic(self.disponible_time,dl)
    else
      self.reason       = "Se inicio"
      self.description  = "Se inicio"
    end
    self.status       = "active"
    return self.save
  end
  
  def standby_working_day(hash={})
    self.status       = "standby"
    self.reason       = "standby"
    self.description  = "standby"
    self.stoppage_id = hash[:stoppage_id]
    return self.save
  end
  
  def stop_working_day(hash={})
    self.status       = "stop"
    self.reason       = "stop"
    self.description  = "stop"
    self.end_time    =Time.now.strftime("%H:%M:%S")
    return self.save
  end
  
  def calculate_item_piece(hash)
    return false if self.status != 'active'
    rason_description = 0 < hash[:number_piece].to_i ? "add item" : "remove item"
    self.number_piece = self.number_piece.nullo.if_nil(0) + hash[:number_piece].to_i
    self.effective_time = hash[:time]
    #self.delayed_time = (self.delayed_time.to_time - Time.parse(hash[:cron]).to_f).strftime("%H:%M:%S") if self.status == 'pausa'
    self.cost_production = self.get_cost_production
    self.percentage_production = self.calcul_percentage
    self.description  = rason_description
    self.reason       = rason_description
    self.average_piece = self.calcul_averenge
    return self.save
  end
  
  def get_cost_production
    minutes = get_minutes_time(self.effective_time)
    sum_inputs = 0
    self.standard.inputs.each do |inp|
      sum_inputs += (minutes * inp.cost_per_unit)/10 #FIXME agergar configuracion de minutos por unidad
    end
    return sum_inputs.round(3)
  end
  
  def calcul_averenge
    return (Time.new(2000) + (get_minutes_time(self.effective_time)/self.number_piece).minutes).strftime("%H:%M:%S")
  end
  
  def get_averenge_time_second
    return 10 * 60 * 1000 if self.disponible_time.blank?
    minutes_disponible = get_minutes_time(self.disponible_time)
    minutes_effective = get_minutes_time(Time.parse(self.station.get_sum_effective_time))
    avarange = (Time.new(2000) + ((minutes_disponible - minutes_effective)/(self.target_pieces - self.number_piece.nullo.if_nil(0))).minutes)#.strftime("%H:%M:%S")
    return (((avarange.hour*60)+avarange.min)*60+avarange.sec)*1000
  end
  
  def calcul_percentage
    return (self.number_piece * 100)/self.standard.item_number
  end
  
  def get_minutes_time(times)
    times.min + (times.hour * 60)
  end

  def get_time_available
    worktime = PConfig::WorkTime.total_hours
    total_boot_variables = PConfig::BootVariable.get_time_sum self.standard.boot_variables.only_start_variable
    return (worktime - total_boot_variables.to_f).utc.strftime("%H:%M:%S")
  end
  
end
