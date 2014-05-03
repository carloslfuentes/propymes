class Prescription < ActiveRecord::Base
  #attr_accessible :user_id, :patient_id, :consult_id
  belongs_to    :consult, :foreign_key => :consult_id
  has_many   :medicines
  belongs_to    :patient
  belongs_to    :user
  accepts_nested_attributes_for :medicines 
end
