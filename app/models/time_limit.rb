class TimeLimit < ActiveRecord::Base
  has_one   :organization
  
  default_value_for   :is_active, false
  
  scope :check_time_linit, proc {|user_id, date| where("user_id = ? and start_date < ? and end_date > ?",user_id,date,date)}
  scope :get_enabled_user_date, proc {|organization_id,date| where("organization_id = ? and start_date < ? and is_active = ?",organization_id,date,true)}
  
  def check_status
    date_now = Date.today
    return start_date < date_now && end_date > date_now
  end
end
