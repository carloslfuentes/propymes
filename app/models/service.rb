class Service < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :organization
  has_one     :consult_service
  scope :for_organization, proc{|organization_id| where(:organization_id=>organization_id)}
  scope :for_user, proc{|user_id| where(:user_id=>user_id)}
  scope :is_enabled, where(:is_active=>true)
  scope :by_medic, proc{|medic| where(:user_id=>medic,:is_active=>true)}
end
