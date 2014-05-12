module PConfig
  class UserSession < Authlogic::Session::Base
    validate :check_sessions
    after_save :set_session_id
  
    single_access_allowed_request_types :any
  
    logout_on_timeout true # default if false
  
    def check_sessions      
      controller=self.class.controller
  
      if not attempted_record.nil?
        temp = controller.request.session_options[:id]      
        if attempted_record.session_key != nil && controller.request.session_options[:id]!=nil then
          if attempted_record.session_key !=  controller.request.session_options[:id]       
            if !attempted_record.last_request_at.nil? && attempted_record.last_request_at > 10.minutes.ago
              errors.add(:base, I18n.t("error_messages.simultaneous_logins", :default => "Access denied. Simultaneous logins detected."))   
              attempted_record.session_key =  controller.request.session_options[:id]
            else
              attempted_record.session_key =  controller.request.session_options[:id]
            end
          end
        end
      end
    end
    
    def set_session_id
       temp = controller.request.session_options[:id] 
       record.session_key =  controller.request.session_options[:id]           
    end
    
    def to_key 
      new_record? ? nil : [ self.send(self.class.primary_key) ] 
    end
    
    def persisted?
      false
    end
  end
end