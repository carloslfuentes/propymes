class AssistantMedic < ActiveRecord::Base
  belongs_to :medic, :class_name => "User", :foreign_key => "assistant_id"
  belongs_to :assistant, :class_name => "User", :foreign_key => "medic_id"
end
