class ConfigurationMailer < ActiveRecord::Base
  belongs_to :user, :class_name => 'User', :foreign_key => "object_id"
end
