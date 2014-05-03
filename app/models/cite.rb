class Cite < ActiveRecord::Base
  belongs_to   :patient
  belongs_to   :user
  belongs_to      :consult
  validates_presence_of :user_id
  validates_presence_of :patient_id
  validates_presence_of :date_cite
  #validates_uniqueness_of :date_cite
  default_value_for   :is_active, true
  scope :for_date_cite, proc{|date| where(:date_cite=>date)}
  scope :for_user_medic, proc{|user_id| where(:user_id=>user_id)}
  scope :is_enabled, where(:is_active=>true)
end
