class Role < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  
  scope :for_user_id, proc{|user_id| where(:user_id=>user_id)}
end
