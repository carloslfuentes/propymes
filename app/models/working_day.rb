class WorkingDay < ActiveRecord::Base
  belongs_to :station, :class_name=>"PConfig::Station"
  belongs_to :user, :class_name=>"PConfig::User",:foreign_key => "operator_id"
  
  after_save :add_log
  validates_presence_of :reason  
  
  def add_log
      WorkingDayLog.create(:working_day_id=>self.id, :description=>self.reason)
  end
end
