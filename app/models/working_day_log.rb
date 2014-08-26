class WorkingDayLog < ActiveRecord::Base
  belongs_to :working_day
  
  scope :add_item, where("reason = ?","add item")
  scope :change_product, where("reason = ?","change product")
end
