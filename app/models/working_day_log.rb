class WorkingDayLog < ActiveRecord::Base
  belongs_to :working_day
  
  scope :add_item, where("reason = ?","add item")
end
