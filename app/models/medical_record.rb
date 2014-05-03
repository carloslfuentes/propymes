class MedicalRecord < ActiveRecord::Base
  #attr_accessible :user_id, :patient_id, :consult_id, :description
  belongs_to :patient
  has_one :consult
  
end
