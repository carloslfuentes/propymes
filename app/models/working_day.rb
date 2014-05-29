class WorkingDay < ActiveRecord::Base
  belongs_to :station, :class_name=>"PConfig::Station"
  belongs_to :user, :class_name=>"PConfig::User",:foreign_key => "operator_id"
  belongs_to :standard
  
  after_save :add_log
  validates_presence_of :reason  
  
  def add_log
    WorkingDayLog.create(:product_id=>self.product_id,:working_day_id=>self.id, :description=>self.reason)
  end
  
  def self.get_working_day(sation, current_user_id,product_id=nil)
    if (working_day = WorkingDay.where("status in ('pausa','waiting_active','active') and station_id = ?", sation_id ).first).blank?
        working_day = WorkingDay.create(:product_id=>product_id,:reason=>'por iniciar',:status=>'waiting_active',:standard_id=>sation.standard.id,:station_id=>sation.id,:operator_id=>current_user_id)
    end
    return working_day
  end
  
  def calculate_item(hash)
    self.number_piece = self.number_piece.nullo.if_nil(0) + hash[:number_piece] 
    self.percentage_production = self.calcul_percentage
    self.save
  end
  
  def calcul_percentage
    return (self.number_piece * 100)/self.standard.item_number
  end
  
  def get_time_available
    worktime = PConfig::WorkTime.first
    self.standard.boots_variables.sum(:time)
  end
end
