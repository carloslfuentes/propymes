class Patient < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_many    :medical_records
  has_many    :consults
  has_many    :cites
  belongs_to  :user
  has_many     :patient_insurance
  has_many    :addresses, :foreign_key => "patient_id"
  accepts_nested_attributes_for :addresses
  scope :for_user_medic, proc{|user_id| where(:user_id=>user_id)}
end
