class WorkingDay < ActiveRecord::Base
  belongs_to :station, :class_name=>"PConfig::Station"
  belongs_to :user, :class_name=>"PConfig::User",:foreign_key => "operator_id"
  
  after_save :add_log
  validates_presence_of :reason  
  
  def add_log
    WorkingDayLog.create(:product_id=>self.product_id,:working_day_id=>self.id, :description=>self.reason)
  end
  
  def self.get_working_day(sation_id, current_user_id,product_id=nil)
    if (working_day = WorkingDay.where("status in ('pausa','waiting_active','active') and station_id = ?", sation_id ).first).blank?
        working_day = WorkingDay.create(:product_id=>product_id,:reason=>'por iniciar',:status=>'waiting_active',:station_id=>sation_id,:operator_id=>current_user_id)
    end
    return working_day
  end
end
