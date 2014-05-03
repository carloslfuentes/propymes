class Insurance < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :organization
  has_many    :patient_insurance
  
  scope :by_medic, proc{|medic| where(:user_id=>medic,:is_active=>true)}
end
