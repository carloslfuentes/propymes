class PaymentMethod < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :organization
  #belongs_to  :document
  
  scope :is_enabled, where(:is_active=>true)
end
