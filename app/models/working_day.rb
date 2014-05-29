class WorkingDay < ActiveRecord::Base
  belongs_to :station, :class_name=>"PConfig::Station"
  belongs_to :user, :class_name=>"PConfig::User",:foreign_key => "operator_id"
  belongs_to :standard, :class_name=>"PConfig::Standard"
  has_many   :working_day_logs
  after_save :add_log
  validates_presence_of :reason  
  
  def add_log
    WorkingDayLog.create(:product_id=>self.product_id,:working_day_id=>self.id, :description=>self.reason)
  end
  
  def self.get_working_day(station, current_user_id,product_id=nil)
    if (working_day = WorkingDay.where("status in ('pausa','waiting_active','active') and station_id = ?", station.id ).first).blank?
        time_disponible = (PConfig::WorkTime.total_hours - PConfig::BootVariable.get_time_sum(station.standard.boot_variables).to_f).utc.strftime("%H:%M:%S")
        working_day = WorkingDay.create(:disponible_time=>time_disponible,:product_id=>product_id,:reason=>'por iniciar',:status=>'waiting_active',:standard_id=>station.standard.id,:station_id=>station.id,:operator_id=>current_user_id)
    end
    return working_day
  end
  
  def calculate_item_piece(hash)
    self.number_piece = self.number_piece.nullo.if_nil(0) + hash[:number_piece]
    #self.effective_time = self.effective_time.present? ? (self.effective_time.to_datetime + Time.now.to_f).utc.strftime("%H:%M:%S") : DateTime.now.strftime("%H:%M:%S") if self.status == 'active'
    self.percentage_production = self.calcul_percentage
    self.save
  end
  
  def calcul_percentage
    return (self.number_piece * 100)/self.standard.item_number
  end
  
  def get_time_available
    worktime = PConfig::WorkTime.total_hours
    total_boot_variables = PConfig::BootVariable.get_time_sum self.standard.boot_variables
  end
end
