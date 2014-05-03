class Medicine < ActiveRecord::Base
  belongs_to    :prescription
  validates_presence_of :medicine
  validates_presence_of :dose
  
end
