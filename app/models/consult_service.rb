class ConsultService < ActiveRecord::Base
  belongs_to :consult
  belongs_to :service
end
