class Address < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to   :patient
  belongs_to   :user
  belongs_to   :state
  belongs_to   :country
  belongs_to   :organization, :foreign_key => "organization_id"
end
